compile abstract instructions
genConvertIntegerToSmallIntegerInReg: reg
	cogit LogicalShiftLeftCq: self numTagBits R: reg.
	cogit AddCq: 1 R: reg.
	^0