compile abstract instructions
genConvertSmallIntegerToIntegerInReg: reg
	cogit ArithmeticShiftRightCq: self numTagBits R: reg.
	^0