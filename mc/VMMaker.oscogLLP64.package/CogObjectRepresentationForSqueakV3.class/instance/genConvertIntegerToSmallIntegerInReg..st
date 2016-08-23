compile abstract instructions
genConvertIntegerToSmallIntegerInReg: reg
	cogit LogicalShiftLeftCq: 1 R: reg.
	cogit AddCq: 1 R: reg.
	^0