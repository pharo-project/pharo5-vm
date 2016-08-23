primitive generators
genPrimitiveAsCharacter
	| reg jumpNotInt jumpOutOfRange |
	<var: 'jumpNotInt' type: #'AbstractInstruction *'>
	<var: 'jumpOutOfRange' type: #'AbstractInstruction *'>
	cogit methodNumArgs = 0
		ifTrue: [reg := ReceiverResultReg]
		ifFalse:
			[cogit methodNumArgs > 1 ifTrue:
				[^UnimplementedPrimitive].
			 reg := Arg0Reg.
			 cogit genLoadArgAtDepth: 0 into: Arg0Reg.
			 jumpNotInt := self genJumpNotSmallInteger: reg scratchReg: TempReg].
	cogit MoveR: reg R: TempReg.
	self genConvertSmallIntegerToIntegerInReg: TempReg.
	jumpOutOfRange := self jumpNotCharacterUnsignedValueInRegister: TempReg.
	self genConvertSmallIntegerToCharacterInReg: reg.
	reg ~= ReceiverResultReg ifTrue:
		[cogit MoveR: reg R: ReceiverResultReg].
	cogit genPrimReturn.
	jumpOutOfRange jmpTarget: cogit Label.
	reg ~= ReceiverResultReg ifTrue:
		[jumpNotInt jmpTarget: jumpOutOfRange getJmpTarget].
	^CompletePrimitive