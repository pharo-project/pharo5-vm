bytecode generators
genSpecialSelectorArithmetic
	| primDescriptor rcvrIsConst argIsConst rcvrIsInt argIsInt rcvrInt argInt result
	 jumpNotSmallInts jumpContinue annotateInst instToAnnotate |
	<var: #primDescriptor type: #'BytecodeDescriptor *'>
	<var: #jumpNotSmallInts type: #'AbstractInstruction *'>
	<var: #jumpContinue type: #'AbstractInstruction *'>
	<var: #instToAnnotate type: #'AbstractInstruction *'>
	primDescriptor := self generatorAt: byte0.
	argIsInt := (argIsConst := self ssTop type = SSConstant)
				 and: [objectMemory isIntegerObject: (argInt := self ssTop constant)].
	rcvrIsInt := (rcvrIsConst := (self ssValue: 1) type = SSConstant)
				 and: [objectMemory isIntegerObject: (rcvrInt := (self ssValue: 1) constant)].

	(argIsInt and: [rcvrIsInt]) ifTrue:
		[rcvrInt := objectMemory integerValueOf: rcvrInt.
		 argInt := objectMemory integerValueOf: argInt.
		 primDescriptor opcode caseOf: {
			[AddRR]	-> [result := rcvrInt + argInt].
			[SubRR]	-> [result := rcvrInt - argInt].
			[AndRR]	-> [result := rcvrInt bitAnd: argInt].
			[OrRR]	-> [result := rcvrInt bitOr: argInt] }.
		(objectMemory isIntegerValue: result) ifTrue:
			["Must enter any annotatedConstants into the map"
			 self annotateBytecodeIfAnnotated: (self ssValue: 1).
			 self annotateBytecodeIfAnnotated: self ssTop.
			 "Must annotate the bytecode for correct pc mapping."
			^self ssPop: 2; ssPushAnnotatedConstant: (objectMemory integerObjectOf: result)].
		^self genSpecialSelectorSend].

	"If there's any constant involved other than a SmallInteger don't attempt to inline."
	((rcvrIsConst and: [rcvrIsInt not])
	 or: [argIsConst and: [argIsInt not]]) ifTrue:
		[^self genSpecialSelectorSend].

	"If we know nothing about the types then better not to inline as the inline cache and
	 primitive code is not terribly slow so wasting time on duplicating tag tests is pointless."
	(argIsInt or: [rcvrIsInt]) ifFalse:
		[^self genSpecialSelectorSend].

	argIsInt
		ifTrue:
			[self ssFlushTo: simStackPtr - 2.
			 (self ssValue: 1) popToReg: ReceiverResultReg.
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
	primDescriptor opcode caseOf: {
		[AddRR] -> [argIsInt
						ifTrue:
							[instToAnnotate := self AddCq: argInt - ConstZero R: ReceiverResultReg.
							 jumpContinue := self JumpNoOverflow: 0.
							 "overflow; must undo the damage before continuing"
							 self SubCq: argInt - ConstZero R: ReceiverResultReg]
						ifFalse:
							[objectRepresentation genRemoveSmallIntegerTagsInScratchReg: ReceiverResultReg.
							 self AddR: Arg0Reg R: ReceiverResultReg.
							jumpContinue := self JumpNoOverflow: 0.
							"overflow; must undo the damage before continuing"
							 rcvrIsInt
								ifTrue: [self MoveCq: rcvrInt R: ReceiverResultReg]
								ifFalse:
									[self SubR: Arg0Reg R: ReceiverResultReg.
									 objectRepresentation genSetSmallIntegerTagsIn: ReceiverResultReg]]].
		[SubRR] -> [argIsInt
						ifTrue:
							[instToAnnotate := self SubCq: argInt - ConstZero R: ReceiverResultReg.
							 jumpContinue := self JumpNoOverflow: 0.
							 "overflow; must undo the damage before continuing"
							 self AddCq: argInt - ConstZero R: ReceiverResultReg]
						ifFalse:
							[objectRepresentation genRemoveSmallIntegerTagsInScratchReg: Arg0Reg.
							 self SubR: Arg0Reg R: ReceiverResultReg.
							 jumpContinue := self JumpNoOverflow: 0.
							 "overflow; must undo the damage before continuing"
							 self AddR: Arg0Reg R: ReceiverResultReg.
							 objectRepresentation genSetSmallIntegerTagsIn: Arg0Reg]].
		[AndRR] -> [argIsInt
						ifTrue: [instToAnnotate := self AndCq: argInt R: ReceiverResultReg]
						ifFalse: [self AndR: Arg0Reg R: ReceiverResultReg].
					jumpContinue := self Jump: 0].
		[OrRR]	-> [argIsInt
						ifTrue: [instToAnnotate := self OrCq: argInt R: ReceiverResultReg]
						ifFalse: [self OrR: Arg0Reg R: ReceiverResultReg].
					jumpContinue := self Jump: 0] }.
	jumpNotSmallInts jmpTarget: self Label.
	argIsInt ifTrue:
		[annotateInst ifTrue: [self annotateBytecode: instToAnnotate].
		 self MoveCq: argInt R: Arg0Reg].
	self genMarshalledSend: (coInterpreter specialSelector: byte0 - self firstSpecialSelectorBytecodeOffset)
		numArgs: 1.
	jumpContinue jmpTarget: self Label.
	^0