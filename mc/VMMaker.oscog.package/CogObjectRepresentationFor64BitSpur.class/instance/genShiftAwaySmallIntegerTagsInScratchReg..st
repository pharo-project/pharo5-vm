compile abstract instructions
genShiftAwaySmallIntegerTagsInScratchReg: scratchReg
	cogit ArithmeticShiftRightCq: objectMemory numTagBits R: scratchReg.
	^0