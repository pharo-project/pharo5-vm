bytecode generators
genSpecialSelectorComparison
	| nextPC postBranchPC targetPC primDescriptor branchDescriptor
	  rcvrIsInt argIsInt argInt jumpNotSmallInts inlineCAB index rcvrReg argReg branchToTarget needMergeToContinue needMergeToTarget |
	<var: #primDescriptor type: #'BytecodeDescriptor *'>
	<var: #branchDescriptor type: #'BytecodeDescriptor *'>
	<var: #jumpNotSmallInts type: #'AbstractInstruction *'>
	primDescriptor := self generatorAt: byte0.
	argIsInt := self ssTop type = SSConstant
				 and: [objectMemory isIntegerObject: (argInt := self ssTop constant)].
	rcvrIsInt := (self ssValue: 1) type = SSConstant
				 and: [objectMemory isIntegerObject: (self ssValue: 1) constant].

	(argIsInt and: [rcvrIsInt]) ifTrue:
		[^self genStaticallyResolvedSpecialSelectorComparison].

	self extractMaybeBranchDescriptorInto: [ :descr :next :postBranch :target | 
		branchDescriptor := descr. nextPC := next. postBranchPC := postBranch. targetPC := target ].

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
			 (self ssValue: 1) popToReg: rcvrReg]
		ifFalse:
			[self allocateRegForStackTopTwoEntriesInto: [:rTop :rNext| argReg := rTop. rcvrReg := rNext].
			 rcvrReg = Arg0Reg ifTrue:
				[rcvrReg := argReg. argReg := Arg0Reg].
			 self ssTop popToReg: argReg.
			 (self ssValue: 1) popToReg: rcvrReg.
			 rcvrIsInt ifFalse:
				[self MoveR: argReg R: TempReg]].
	self ssPop: 2.
	jumpNotSmallInts := (argIsInt or: [rcvrIsInt])
							ifFalse: "Neither known to be ints; and them together for the test..."
								[objectRepresentation genJumpNotSmallIntegersIn: rcvrReg andScratch: TempReg scratch: ClassReg]
							ifTrue: "One known; in-place single-bit test for the other"
								[objectRepresentation genJumpNotSmallInteger: (rcvrIsInt ifTrue: [argReg] ifFalse: [rcvrReg])].
	argIsInt
		ifTrue: [self CmpCq: argInt R: rcvrReg]
		ifFalse: [self CmpR: argReg R: rcvrReg].

	"self printSimStack; printSimStack: (self fixupAt: postBranchPC) mergeSimStack; printSimStack: (self fixupAt: targetPC) mergeSimStack"
	"If there are merges to be performed on the forward branches we have to execute
	 the merge code only along the path requiring that merge, and exactly once."
	needMergeToTarget := self mergeRequiredForJumpTo: targetPC.
	needMergeToContinue := self mergeRequiredForJumpTo: postBranchPC.
	"Cmp is weird/backwards so invert the comparison."
	(needMergeToTarget and: [needMergeToContinue]) ifTrue:
		[branchToTarget := self genConditionalBranch: (branchDescriptor isBranchTrue
										ifTrue: [primDescriptor opcode]
										ifFalse: [self inverseBranchFor: primDescriptor opcode])
								operand: 0.
		 self Jump: (self ensureFixupAt: postBranchPC).
		 branchToTarget jmpTarget: self Label.
		 self Jump: (self ensureFixupAt: targetPC)].
	(needMergeToTarget and: [needMergeToContinue not]) ifTrue:
		[self genConditionalBranch: (branchDescriptor isBranchFalse
										ifTrue: [primDescriptor opcode]
										ifFalse: [self inverseBranchFor: primDescriptor opcode])
			operand: (self ensureFixupAt: postBranchPC) asUnsignedInteger.
		 self Jump: (self ensureFixupAt: targetPC)].
	(needMergeToTarget not and: [needMergeToContinue]) ifTrue:
		[self genConditionalBranch: (branchDescriptor isBranchTrue
										ifTrue: [primDescriptor opcode]
										ifFalse: [self inverseBranchFor: primDescriptor opcode])
			operand: (self ensureFixupAt: targetPC) asUnsignedInteger.
		 self Jump: (self ensureFixupAt: postBranchPC)].
	(needMergeToTarget or: [needMergeToContinue]) ifFalse:
		[self genConditionalBranch: (branchDescriptor isBranchTrue
										ifTrue: [primDescriptor opcode]
										ifFalse: [self inverseBranchFor: primDescriptor opcode])
			operand: (self ensureFixupAt: targetPC) asUnsignedInteger.
		 self Jump: (self ensureFixupAt: postBranchPC)].
	jumpNotSmallInts jmpTarget: self Label.
	self ssFlushTo: simStackPtr.
	self deny: rcvrReg = Arg0Reg.
	argIsInt
		ifTrue: [self MoveCq: argInt R: Arg0Reg]
		ifFalse: [argReg ~= Arg0Reg ifTrue: [self MoveR: argReg R: Arg0Reg]].
	rcvrReg ~= ReceiverResultReg ifTrue: [self MoveR: rcvrReg R: ReceiverResultReg].
	index := byte0 - self firstSpecialSelectorBytecodeOffset.
	^self genMarshalledSend: index negated - 1 numArgs: 1 sendTable: ordinarySendTrampolines