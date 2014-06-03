compile abstract instructions
genConvertCharacterToCodeInReg: reg 
	cogit LogicalShiftRightCq: objectMemory numTagBits R: reg.
	^0