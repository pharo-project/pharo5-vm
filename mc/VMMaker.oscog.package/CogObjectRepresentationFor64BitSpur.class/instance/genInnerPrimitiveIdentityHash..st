primitive generators
genInnerPrimitiveIdentityHash: retNoffset
	| jumpImm jumpSF jumpNotSet ret |
	<var: #jumpSF type: #'AbstractInstruction *'>
	<var: #jumpImm type: #'AbstractInstruction *'>
	<var: #jumpNotSet type: #'AbstractInstruction *'>
	jumpImm := self genJumpImmediate: ReceiverResultReg. "uses TstCqR"
	self genGetHashFieldNonImmOf: ReceiverResultReg asSmallIntegerInto: TempReg.
	cogit CmpCq: ConstZero R: TempReg.
	jumpNotSet := cogit JumpZero: 0.
	cogit MoveR: TempReg R: ReceiverResultReg.
	ret := cogit RetN: retNoffset.
	jumpImm jmpTarget: cogit Label.
	jumpSF := cogit "Fail SmallFloat because their hash uses rotatedFloatBitsOf: the oop"
		AndCq: objectMemory tagMask R: ReceiverResultReg R: TempReg;
		CmpCq: objectMemory smallIntegerTag R: TempReg;
		JumpZero: ret;
		CmpCq: objectMemory characterTag R: TempReg;
		JumpNonZero: 0.
	self genConvertCharacterToSmallIntegerInReg: ReceiverResultReg.
	cogit Jump: ret.
	jumpNotSet jmpTarget: (jumpSF jmpTarget: cogit Label).
	^0