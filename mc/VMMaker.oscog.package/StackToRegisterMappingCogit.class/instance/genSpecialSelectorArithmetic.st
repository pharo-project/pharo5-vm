bytecode generators
genSpecialSelectorArithmetic
	| primDescriptor rcvrIsConst argIsConst rcvrIsInt argIsInt rcvrInt argInt result
	 jumpNotSmallInts jumpContinue index |
	<var: #jumpContinue type: #'AbstractInstruction *'>
	<var: #primDescriptor type: #'BytecodeDescriptor *'>
	<var: #jumpNotSmallInts type: #'AbstractInstruction *'>
	primDescriptor := self generatorAt: byte0.
	argIsInt := (argIsConst := self ssTop type = SSConstant)
				 and: [objectMemory isIntegerObject: (argInt := self ssTop constant)].
	rcvrIsInt := ((rcvrIsConst := (self ssValue: 1) type = SSConstant)
				  and: [objectMemory isIntegerObject: (rcvrInt := (self ssValue: 1) constant)])
				or: [self mclassIsSmallInteger and: [(self ssValue: 1) isSameEntryAs: (self addressOf: simSelf)]].

	(argIsInt and: [rcvrIsInt and: [rcvrIsConst]]) ifTrue:
		[rcvrInt := objectMemory integerValueOf: rcvrInt.
		 argInt := objectMemory integerValueOf: argInt.
		 primDescriptor opcode caseOf: {
			[AddRR]	-> [result := rcvrInt + argInt].
			[SubRR]	-> [result := rcvrInt - argInt].
			[AndRR]	-> [result := rcvrInt bitAnd: argInt].
			[OrRR]	-> [result := rcvrInt bitOr: argInt] }.
		(objectMemory isIntegerValue: result) ifTrue:
			["Must annotate the bytecode for correct pc mapping."
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
			 self ssPop: 2]
		ifFalse:
			[self marshallSendArguments: 1].
	jumpNotSmallInts := (rcvrIsInt and: [argIsInt]) ifFalse:
							[argIsInt
								ifTrue: [objectRepresentation genJumpNotSmallInteger: ReceiverResultReg]
								ifFalse:
									[rcvrIsInt
										ifTrue: [objectRepresentation genJumpNotSmallInteger: Arg0Reg]
										ifFalse: [objectRepresentation genJumpNotSmallIntegersIn: ReceiverResultReg and: Arg0Reg scratch: TempReg]]].
	primDescriptor opcode caseOf: {
		[AddRR] -> [argIsInt
						ifTrue:
							[self AddCq: argInt - ConstZero R: ReceiverResultReg.
							 jumpContinue := self JumpNoOverflow: 0.
							 "overflow; must undo the damage before continuing"
							 self SubCq: argInt - ConstZero R: ReceiverResultReg]
						ifFalse:
							[objectRepresentation genRemoveSmallIntegerTagsInScratchReg: ReceiverResultReg.
							 self AddR: Arg0Reg R: ReceiverResultReg.
							jumpContinue := self JumpNoOverflow: 0.
							"overflow; must undo the damage before continuing"
							 (rcvrIsInt and: [rcvrIsConst])
								ifTrue: [self MoveCq: rcvrInt R: ReceiverResultReg]
								ifFalse:
									[self SubR: Arg0Reg R: ReceiverResultReg.
									 objectRepresentation genSetSmallIntegerTagsIn: ReceiverResultReg]]].
		[SubRR] -> [argIsInt
						ifTrue:
							[self SubCq: argInt - ConstZero R: ReceiverResultReg.
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
						ifTrue: [self AndCq: argInt R: ReceiverResultReg]
						ifFalse: [self AndR: Arg0Reg R: ReceiverResultReg].
					jumpContinue := jumpNotSmallInts ifNotNil: [self Jump: 0]].
		[OrRR]	-> [argIsInt
						ifTrue: [self OrCq: argInt R: ReceiverResultReg]
						ifFalse: [self OrR: Arg0Reg R: ReceiverResultReg].
					jumpContinue := jumpNotSmallInts ifNotNil: [self Jump: 0]] }.
	jumpNotSmallInts
		ifNil: [jumpContinue ifNil: "overflow cannot happen"
				[self annotateInstructionForBytecode.
				 self ssPushRegister: ReceiverResultReg.
				 ^0]]
		ifNotNil:
			[jumpNotSmallInts jmpTarget: self Label].
	argIsInt ifTrue:
		[self MoveCq: argInt R: Arg0Reg].
	index := byte0 - self firstSpecialSelectorBytecodeOffset.
	self genMarshalledSend: index negated - 1 numArgs: 1 sendTable: ordinarySendTrampolines.
	jumpContinue jmpTarget: self Label.
	^0