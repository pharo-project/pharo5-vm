compile abstract instructions
genConvertSmallIntegerToIntegerInScratchReg: scratchReg
	cogit ArithmeticShiftRightCq: 1 R: scratchReg.
	^0