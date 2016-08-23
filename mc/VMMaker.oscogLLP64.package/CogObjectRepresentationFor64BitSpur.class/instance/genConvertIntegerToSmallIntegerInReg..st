compile abstract instructions
genConvertIntegerToSmallIntegerInReg: reg
	cogit LogicalShiftLeftCq: objectMemory numTagBits R: reg.
	cogit AddCq: 1 R: reg.
	^0