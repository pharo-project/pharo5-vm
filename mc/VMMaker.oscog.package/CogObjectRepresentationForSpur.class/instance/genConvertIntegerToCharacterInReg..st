compile abstract instructions
genConvertIntegerToCharacterInReg: reg
	cogit
		LogicalShiftLeftCq: objectMemory numTagBits R: reg;
		AddCq: objectMemory characterTag R: reg.
	^0