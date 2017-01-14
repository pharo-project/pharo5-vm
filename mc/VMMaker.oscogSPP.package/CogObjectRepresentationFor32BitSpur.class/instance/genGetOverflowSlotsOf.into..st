compile abstract instructions
genGetOverflowSlotsOf: srcReg into: destReg
	cogit MoveMw: objectMemory baseHeaderSize negated r: srcReg R: destReg.
	^0