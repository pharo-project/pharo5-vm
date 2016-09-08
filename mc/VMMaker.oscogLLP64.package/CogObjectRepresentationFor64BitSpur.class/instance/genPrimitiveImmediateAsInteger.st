primitive generators
genPrimitiveImmediateAsInteger
	| jumpNotCharacter ret |
	<var: #jumpNotCharacter type: #'AbstractInstruction *'>
	jumpNotCharacter := cogit
		AndCq: objectMemory tagMask R: ReceiverResultReg R: TempReg;
		CmpCq: objectMemory characterTag R: TempReg;
		JumpNonZero: 0.
	self genConvertCharacterToSmallIntegerInReg: ReceiverResultReg.
	ret := cogit genPrimReturn.
	jumpNotCharacter jmpTarget:
		(cogit CmpCq: objectMemory smallFloatTag R: TempReg).
	cogit JumpNonZero: ret.
	self genConvertSmallFloatToSmallFloatHashAsIntegerInReg: ReceiverResultReg scratch: TempReg.
	cogit genPrimReturn.
	^UnfailingPrimitive