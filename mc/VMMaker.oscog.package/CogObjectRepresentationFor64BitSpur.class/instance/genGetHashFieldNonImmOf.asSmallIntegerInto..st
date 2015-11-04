compile abstract instructions
genGetHashFieldNonImmOf: instReg asSmallIntegerInto: destReg
	"Fetch the instance's identity hash into destReg, encoded as a SmallInteger."
	"Get header word in scratchReg"
	cogit MoveMw: 0 r: instReg R: destReg.
	"Shift and mask the field leaving room for the SmallInteger tag."
	cogit LogicalShiftRightCq: objectMemory identityHashFullWordShift R: destReg.
	cogit AndCq: objectMemory identityHashHalfWordMask R: destReg.
	self genConvertIntegerToSmallIntegerInReg: destReg.
	^0