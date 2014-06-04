compile abstract instructions
genConvertIntegerToSmallIntegerInScratchReg: scratchReg
	cogit LogicalShiftLeftCq: 1 R: scratchReg.
	cogit AddCq: 1 R: scratchReg.
	^0