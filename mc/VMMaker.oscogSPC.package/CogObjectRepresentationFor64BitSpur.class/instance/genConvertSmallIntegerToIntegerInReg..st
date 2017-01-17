compile abstract instructions
genConvertSmallIntegerToIntegerInReg: reg
	cogit ArithmeticShiftRightCq: objectMemory numTagBits R: reg.
	^0