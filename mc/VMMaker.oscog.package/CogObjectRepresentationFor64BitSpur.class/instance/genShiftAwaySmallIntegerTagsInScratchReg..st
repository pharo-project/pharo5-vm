compile abstract instructions
genShiftAwaySmallIntegerTagsInScratchReg: scratchReg
	cogit ArithmeticShiftRightCq: self numTagBits R: scratchReg.
	^0