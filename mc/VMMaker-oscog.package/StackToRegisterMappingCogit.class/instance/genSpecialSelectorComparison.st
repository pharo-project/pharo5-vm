bytecode generators
genSpecialSelectorComparison
	| nextPC postBranchPC targetBytecodePC primDescriptor branchDescriptor nExts
	  rcvrIsInt argIsInt rcvrInt argInt result jumpNotSmallInts inlineCAB annotateInst |
	<var: #primDescriptor type: #'BytecodeDescriptor *'>
	<var: #branchDescriptor type: #'BytecodeDescriptor *'>
	<var: #jumpNotSmallInts type: #'AbstractInstruction *'>
	self ssFlushTo: simStackPtr - 2.
	primDescriptor := self generatorAt: byte0.
	argIsInt := self ssTop type = SSConstant
				 and: [objectMemory isIntegerObject: (argInt := self ssTop constant)].
	rcvrIsInt := (self ssValue: 1) type = SSConstant
				 and: [objectMemory isIntegerObject: (rcvrInt := (self ssValue: 1) constant)].

	(argIsInt and: [rcvrIsInt]) ifTrue:
		[self cCode: '' inSmalltalk: "In Simulator ints are unsigned..."
				[rcvrInt := objectMemory integerValueOf: rcvrInt.
				argInt := objectMemory integerValueOf: argInt].
		 primDescriptor opcode caseOf: {
			[JumpLess]				-> [result := rcvrInt < argInt].
			[JumpLessOrEqual]		-> [result := rcvrInt <= argInt].
			[JumpGreater]			-> [result := rcvrInt > argInt].
			[JumpGreaterOrEqual]	-> [result := rcvrInt >= argInt].
			[JumpZero]				-> [result := rcvrInt = argInt].
			[JumpNonZero]			-> [result := rcvrInt ~= argInt] }.
		 "Must enter any annotatedConstants into the map"
		 self annotateBytecodeIfAnnotated: (self ssValue: 1).
		 self annotateBytecodeIfAnnotated: self ssTop.
		 "Must annotate the bytecode for correct pc mapping."
		 self ssPop: 2.
		 ^self ssPushAnnotatedConstant: (result
											ifTrue: [objectMemory trueObject]
											ifFalse: [objectMemory falseObject])].

	nextPC := bytecodePC + primDescriptor numBytes.
	nExts := 0.
	[branchDescriptor := self generatorAt: (objectMemory fetchByte: nextPC ofObject: methodObj) + (byte0 bitAnd: 256).
	 branchDescriptor isExtension] whileTrue:
		[nExts := nExts + 1.
		 nextPC := nextPC + branchDescriptor numBytes].
	"Only interested in inlining if followed by a conditional branch."
	inlineCAB := branchDescriptor isBranchTrue or: [branchDescriptor isBranchFalse].
	"Further, only interested in inlining = and ~= if there's a SmallInteger constant involved.
	 The relational operators successfully statically predict SmallIntegers; the equality operators do not."
	(inlineCAB and: [primDescriptor opcode = JumpZero or: [primDescriptor opcode = JumpNonZero]]) ifTrue:
		[inlineCAB := argIsInt or: [rcvrIsInt]].
	inlineCAB ifFalse:
		[^self genSpecialSelectorSend].

	targetBytecodePC := nextPC
							+ branchDescriptor numBytes
							+ (self spanFor: branchDescriptor at: nextPC exts: nExts in: methodObj).
	postBranchPC := nextPC + branchDescriptor numBytes.
	argIsInt
		ifTrue:
			[(self ssValue: 1) popToReg: ReceiverResultReg.
			 annotateInst := self ssTop annotateUse.
			 self ssPop: 2.
			 self MoveR: ReceiverResultReg R: TempReg]
		ifFalse:
			[self marshallSendArguments: 1.
			 self MoveR: Arg0Reg R: TempReg.
			 rcvrIsInt ifFalse:
				[objectRepresentation isSmallIntegerTagNonZero
					ifTrue: [self AndR: ReceiverResultReg R: TempReg]
					ifFalse: [self OrR: ReceiverResultReg R: TempReg]]].
	jumpNotSmallInts := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	argIsInt
		ifTrue: [annotateInst
					ifTrue: [self annotateBytecode: (self CmpCq: argInt R: ReceiverResultReg)]
					ifFalse: [self CmpCq: argInt R: ReceiverResultReg]]
		ifFalse: [self CmpR: Arg0Reg R: ReceiverResultReg].
	"Cmp is weird/backwards so invert the comparison.  Further since there is a following conditional
	 jump bytecode define non-merge fixups and leave the cond bytecode to set the mergeness."
	self gen: (branchDescriptor isBranchTrue
				ifTrue: [primDescriptor opcode]
				ifFalse: [self inverseBranchFor: primDescriptor opcode])
		operand: (self ensureNonMergeFixupAt: targetBytecodePC - initialPC) asUnsignedInteger.
	self Jump: (self ensureNonMergeFixupAt: postBranchPC - initialPC).
	jumpNotSmallInts jmpTarget: self Label.
	argIsInt ifTrue:
		[self MoveCq: argInt R: Arg0Reg].
	^self genMarshalledSend: (coInterpreter specialSelector: byte0 - self firstSpecialSelectorBytecodeOffset)
		numArgs: 1