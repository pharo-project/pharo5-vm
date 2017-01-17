bytecode generators
genSpecialSelectorComparison
	| nextPC postBranchPC targetBytecodePC primDescriptor branchDescriptor
	  rcvrIsInt argIsInt argInt jumpNotSmallInts inlineCAB index |
	<var: #primDescriptor type: #'BytecodeDescriptor *'>
	<var: #branchDescriptor type: #'BytecodeDescriptor *'>
	<var: #jumpNotSmallInts type: #'AbstractInstruction *'>
	self ssFlushTo: simStackPtr - 2.
	primDescriptor := self generatorAt: byte0.
	argIsInt := self ssTop type = SSConstant
				 and: [objectMemory isIntegerObject: (argInt := self ssTop constant)].
	rcvrIsInt := (self ssValue: 1) type = SSConstant
				 and: [objectMemory isIntegerObject: (self ssValue: 1) constant].

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

	argIsInt
		ifTrue:
			[(self ssValue: 1) popToReg: ReceiverResultReg.
			 self ssPop: 2.
			 self MoveR: ReceiverResultReg R: TempReg]
		ifFalse:
			[self marshallSendArguments: 1.
			 self MoveR: Arg0Reg R: TempReg].
	jumpNotSmallInts := (argIsInt or: [rcvrIsInt])
							ifTrue: [objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg]
							ifFalse: [objectRepresentation genJumpNotSmallIntegersIn: ReceiverResultReg andScratch: TempReg scratch: ClassReg].
	argIsInt
		ifTrue: [self CmpCq: argInt R: ReceiverResultReg]
		ifFalse: [self CmpR: Arg0Reg R: ReceiverResultReg].
	"Cmp is weird/backwards so invert the comparison.  Further since there is a following conditional
	 jump bytecode define non-merge fixups and leave the cond bytecode to set the mergeness."
	self genConditionalBranch: (branchDescriptor isBranchTrue
				ifTrue: [primDescriptor opcode]
				ifFalse: [self inverseBranchFor: primDescriptor opcode])
		operand: (self ensureNonMergeFixupAt: targetBytecodePC - initialPC) asUnsignedInteger.
	self Jump: (self ensureNonMergeFixupAt: postBranchPC - initialPC).
	jumpNotSmallInts jmpTarget: self Label.
	argIsInt ifTrue:
		[self MoveCq: argInt R: Arg0Reg].
	index := byte0 - self firstSpecialSelectorBytecodeOffset.
	^self genMarshalledSend: index negated - 1 numArgs: 1 sendTable: ordinarySendTrampolines