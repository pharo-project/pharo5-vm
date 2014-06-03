primitive generators
genInnerPrimitiveCharacterValue: retNOffset
	self genConvertCharacterToSmallIntegerInReg: ReceiverResultReg.
	cogit RetN: retNOffset.
	^0