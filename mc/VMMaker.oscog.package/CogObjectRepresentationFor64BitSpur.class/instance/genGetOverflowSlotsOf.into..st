compile abstract instructions
genGetOverflowSlotsOf: srcReg into: destReg
	cogit
		MoveMw: objectMemory baseHeaderSize negated r: srcReg R: destReg;
		LogicalShiftLeftCq: 8 R: destReg;
		LogicalShiftRightCq: 8 R: destReg.
	^0