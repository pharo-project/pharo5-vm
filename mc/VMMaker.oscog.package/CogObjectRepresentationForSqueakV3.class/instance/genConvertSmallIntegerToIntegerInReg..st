compile abstract instructions
genConvertSmallIntegerToIntegerInReg: reg
	cogit ArithmeticShiftRightCq: 1 R: reg.
	^0