bytecode generators
genSpecialSelectorArithmetic
	| primDescriptor rcvrIsConst argIsConst rcvrIsInt argIsInt rcvrInt argInt destReg
	 jumpNotSmallInts jumpContinue jumpOverflow index rcvrReg argReg regMask |
	<var: #jumpOverflow type: #'AbstractInstruction *'>
	<var: #jumpContinue type: #'AbstractInstruction *'>
	<var: #primDescriptor type: #'BytecodeDescriptor *'>
	<var: #jumpNotSmallInts type: #'AbstractInstruction *'>
	primDescriptor := self generatorAt: byte0.
	argIsInt := (argIsConst := self ssTop type = SSConstant)
				 and: [objectMemory isIntegerObject: (argInt := self ssTop constant)].
	rcvrIsInt := (rcvrIsConst := (self ssValue: 1) type = SSConstant)
				 and: [objectMemory isIntegerObject: (rcvrInt := (self ssValue: 1) constant)].

	(argIsInt and: [rcvrIsInt]) ifTrue:
		[| result |
		 rcvrInt := objectMemory integerValueOf: rcvrInt.
		 argInt := objectMemory integerValueOf: argInt.
		 primDescriptor opcode caseOf: {
			[AddRR]	-> [result := rcvrInt + argInt].
			[SubRR]	-> [result := rcvrInt - argInt].
			[AndRR]	-> [result := rcvrInt bitAnd: argInt].
			[OrRR]		-> [result := rcvrInt bitOr: argInt] }.
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

	"Since one or other of the arguments is an integer we can very likely profit from inlining.
	 But if the other type is not SmallInteger or if the operation overflows then we will need
	 to do a send.  Since we're allocating values in registers we would like to keep those
	 registers live on the inlined path and reload registers along the non-inlined send path.
	 See reconcileRegisterStateForJoinAfterSpecialSelectorSend below."
	argIsInt
		ifTrue:
			[rcvrReg := self allocateRegForStackEntryAt: 1.
			 (self ssValue: 1) popToReg: rcvrReg.
			 self MoveR: rcvrReg R: TempReg.
			 regMask := self registerMaskFor: rcvrReg]
		ifFalse:
			[self allocateRegForStackTopTwoEntriesInto: [:rTop :rNext| argReg := rTop. rcvrReg := rNext].
			 self ssTop popToReg: argReg.
			 (self ssValue: 1) popToReg: rcvrReg.
			 self MoveR: argReg R: TempReg.
			 regMask := self registerMaskFor: rcvrReg and: argReg].

	"rcvrReg can be reused for the result iff the receiver is a constant or is an SSRegister that is not used elsewhere."
	destReg := (rcvrIsInt
				 or: [(self ssValue: 1) type = SSRegister
					 and: [(self anyReferencesToRegister: rcvrReg inAllButTopNItems: 2) not]])
					ifTrue: [rcvrReg]
					ifFalse: [self allocateRegNotConflictingWith: regMask].
	self ssPop: 2.
	jumpNotSmallInts := (argIsInt or: [rcvrIsInt])
							ifTrue: [objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg]
							ifFalse: [objectRepresentation genJumpNotSmallIntegersIn: rcvrReg andScratch: TempReg scratch: ClassReg].
	rcvrReg ~= destReg ifTrue:
		[self MoveR: rcvrReg R: destReg].
	primDescriptor opcode caseOf: {
		[AddRR] -> [argIsInt
						ifTrue:
							[self AddCq: argInt - ConstZero R: destReg.
							 jumpContinue := self JumpNoOverflow: 0.
							 "overflow; must undo the damage before doing send"
							 rcvrReg = destReg ifTrue:
								[self SubCq: argInt - ConstZero R: rcvrReg]]
						ifFalse:
							[objectRepresentation genRemoveSmallIntegerTagsInScratchReg: destReg.
							 self AddR: argReg R: destReg.
							 jumpContinue := self JumpNoOverflow: 0.
							"overflow; must undo the damage before doing send"
							 destReg = rcvrReg ifTrue:
								[rcvrIsInt
									ifTrue: [self MoveCq: rcvrInt R: rcvrReg]
									ifFalse:
										[self SubR: argReg R: rcvrReg.
										 objectRepresentation genSetSmallIntegerTagsIn: rcvrReg]]]].
		[SubRR] -> [argIsInt
						ifTrue:
							[self SubCq: argInt - ConstZero R: destReg.
							 jumpContinue := self JumpNoOverflow: 0.
							 "overflow; must undo the damage before doing send"
							 rcvrReg = destReg ifTrue:
								[self AddCq: argInt - ConstZero R: rcvrReg]]
						ifFalse:
							[(self anyReferencesToRegister: argReg inAllButTopNItems: 0)
								ifTrue: "argReg is live; cannot strip tags and continue on no overflow without restoring tags"
									[objectRepresentation genRemoveSmallIntegerTagsInScratchReg: argReg.
									 self SubR: argReg R: destReg.
									 jumpOverflow := self JumpOverflow: 0.
									 "no overflow; must undo the damage before continuing"
									 objectRepresentation genSetSmallIntegerTagsIn: argReg.
									 jumpContinue := self Jump: 0.
									 jumpOverflow jmpTarget: self Label.
									 "overflow; must undo the damage before doing send"
									 (rcvrIsInt or: [destReg ~= rcvrReg]) ifFalse:
										[self AddR: argReg R: destReg].
									 objectRepresentation genSetSmallIntegerTagsIn: argReg]
								ifFalse:
									[objectRepresentation genRemoveSmallIntegerTagsInScratchReg: argReg.
									 self SubR: argReg R: destReg.
									 jumpContinue := self JumpNoOverflow: 0.
									 "overflow; must undo the damage before doing send"
									 (rcvrIsInt or: [destReg ~= rcvrReg]) ifFalse:
										[self AddR: argReg R: rcvrReg].
									 objectRepresentation genSetSmallIntegerTagsIn: argReg]]].
		[AndRR] -> [argIsInt
						ifTrue: [self AndCq: argInt R: destReg]
						ifFalse: [self AndR: argReg R: destReg].
					jumpContinue := self Jump: 0].
		[OrRR]	-> [argIsInt
						ifTrue: [self OrCq: argInt R: destReg]
						ifFalse: [self OrR: argReg R: destReg].
					jumpContinue := self Jump: 0] }.
	jumpNotSmallInts jmpTarget: self Label.
	self ssPushRegister: destReg.
	self copySimStackToScratch: (simSpillBase min: simStackPtr - 1).
	self ssPop: 1.
	self ssFlushTo: simStackPtr.
	self deny: rcvrReg = Arg0Reg.
	argIsInt
		ifTrue: [self MoveCq: argInt R: Arg0Reg]
		ifFalse: [argReg ~= Arg0Reg ifTrue: [self MoveR: argReg R: Arg0Reg]].
	rcvrReg ~= ReceiverResultReg ifTrue: [self MoveR: rcvrReg R: ReceiverResultReg].
	index := byte0 - self firstSpecialSelectorBytecodeOffset.
	self genMarshalledSend: index negated - 1 numArgs: 1 sendTable: ordinarySendTrampolines.
	self reconcileRegisterStateForJoinAfterSpecialSelectorSend.
	jumpContinue jmpTarget: self Label.
	^0