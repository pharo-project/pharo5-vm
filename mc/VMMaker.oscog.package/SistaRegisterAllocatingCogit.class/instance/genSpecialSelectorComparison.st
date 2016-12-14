bytecode generators
genSpecialSelectorComparison
	"Override to count inlined branches if followed by a conditional branch.
	 We borrow the following conditional branch's counter and when about to
	 inline the comparison we decrement the counter (without writing it back)
	 and if it trips simply abort the inlining, falling back to the normal send which
	 will then continue to the conditional branch which will trip and enter the abort."
	| nextPC postBranchPC targetBytecodePC primDescriptor branchDescriptor
	  rcvrIsInt argIsInt argInt jumpNotSmallInts inlineCAB
	  counterAddress countTripped counterReg index rcvrReg argReg |
	<var: #countTripped type: #'AbstractInstruction *'>
	<var: #primDescriptor type: #'BytecodeDescriptor *'>
	<var: #jumpNotSmallInts type: #'AbstractInstruction *'>
	<var: #branchDescriptor type: #'BytecodeDescriptor *'>

	(coInterpreter isOptimizedMethod: methodObj) ifTrue:
		[^self genSpecialSelectorComparisonWithoutCounters].

	primDescriptor := self generatorAt: byte0.
	argIsInt := self ssTop type = SSConstant
				 and: [objectMemory isIntegerObject: (argInt := self ssTop constant)].
	rcvrIsInt := (self ssValue: 1) type = SSConstant
				 and: [objectMemory isIntegerObject: (self ssValue: 1) constant].

	"short-cut the jump if operands are SmallInteger constants."
	(argIsInt and: [rcvrIsInt]) ifTrue:
		[^ self genStaticallyResolvedSpecialSelectorComparison].

	self extractMaybeBranchDescriptorInto: [ :descr :next :postBranch :target | 
		branchDescriptor := descr. nextPC := next. postBranchPC := postBranch. targetBytecodePC := target ].
	
	"Only interested in inlining if followed by a conditional branch."
	inlineCAB := branchDescriptor isBranchTrue or: [branchDescriptor isBranchFalse].
	"Further, only interested in inlining = and ~= if there's a SmallInteger constant involved.
	 The relational operators successfully statically predict SmallIntegers; the equality operators do not."
	(inlineCAB and: [primDescriptor opcode = JumpZero or: [primDescriptor opcode = JumpNonZero]]) ifTrue:
		[inlineCAB := argIsInt or: [rcvrIsInt]].
	inlineCAB ifFalse:
		[^self genSpecialSelectorSend].

	"In-line the comparison and the jump, but if the types are not SmallInteger then we will need
	 to do a send and fall through to the following conditional branch.  Since we're allocating values
	 in registers we would like to keep those registers live on the inlined path and reload registers
	 along the non-inlined send path.  The merge logic at the branch destinations handles this."
	argIsInt
		ifTrue:
			[rcvrReg := self allocateRegForStackEntryAt: 1.
			 (self ssValue: 1) popToReg: rcvrReg.
			 self MoveR: rcvrReg R: TempReg.
			 counterReg := self allocateRegNotConflictingWith: (self registerMaskFor: rcvrReg)]
		ifFalse:
			[self allocateRegForStackTopTwoEntriesInto: [:rTop :rNext| argReg := rTop. rcvrReg := rNext].
			 rcvrReg = Arg0Reg ifTrue:
				[rcvrReg := argReg. argReg := Arg0Reg].
			 self ssTop popToReg: argReg.
			 (self ssValue: 1) popToReg: rcvrReg.
			 self MoveR: argReg R: TempReg.
			 counterReg := self allocateRegNotConflictingWith: (self registerMaskFor: rcvrReg and: argReg)].
	jumpNotSmallInts := (argIsInt or: [rcvrIsInt])
							ifTrue: [objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg]
							ifFalse: [objectRepresentation genJumpNotSmallIntegersIn: rcvrReg andScratch: TempReg scratch: ClassReg].

	self
		genExecutionCountLogicInto: [ :cAddress :countTripBranch | 
			counterAddress := cAddress. 
			countTripped := countTripBranch ] 
		counterReg: counterReg.

	argIsInt
		ifTrue: [self CmpCq: argInt R: rcvrReg]
		ifFalse: [self CmpR: argReg R: rcvrReg].
	"Cmp is weird/backwards so invert the comparison.  Further since there is a following conditional
	 jump bytecode define non-merge fixups and leave the cond bytecode to set the mergeness."
	self genConditionalBranch: (branchDescriptor isBranchTrue
				ifTrue: [primDescriptor opcode]
				ifFalse: [self inverseBranchFor: primDescriptor opcode])
		operand: (self ensureFixupAt: targetBytecodePC - initialPC) asUnsignedInteger.
		
	self genFallsThroughCountLogicCounterReg: counterReg counterAddress: counterAddress.
	
	self Jump: (self ensureFixupAt: postBranchPC - initialPC).
	countTripped jmpTarget: (jumpNotSmallInts jmpTarget: self Label).
	
	self ssFlushTo: simStackPtr.
	self deny: rcvrReg = Arg0Reg.
	argIsInt
		ifTrue: [self MoveCq: argInt R: Arg0Reg]
		ifFalse: [argReg ~= Arg0Reg ifTrue: [self MoveR: argReg R: Arg0Reg]].
	rcvrReg ~= ReceiverResultReg ifTrue: [self MoveR: rcvrReg R: ReceiverResultReg].
	index := byte0 - self firstSpecialSelectorBytecodeOffset.
	^self genMarshalledSend: index negated - 1 numArgs: 1 sendTable: ordinarySendTrampolines