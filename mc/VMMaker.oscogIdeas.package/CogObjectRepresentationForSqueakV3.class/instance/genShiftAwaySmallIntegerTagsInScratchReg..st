compile abstract instructions
genShiftAwaySmallIntegerTagsInScratchReg: scratchReg
	cogit ArithmeticShiftRightCq: 1 R: scratchReg.
	^0