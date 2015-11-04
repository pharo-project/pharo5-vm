compile abstract instructions
genGetHashFieldNonImmOf: instReg asSmallIntegerInto: destReg
	"Fetch the instance's identity hash into destReg, encoded as a SmallInteger."
	cogit
		MoveMw: 0 r: instReg R: destReg;
		"Shift and mask the field leaving room for the SmallInteger tag."
		LogicalShiftRightCq: objectMemory identityHashFullWordShift - objectMemory numTagBits R: destReg;
		AndCq: objectMemory identityHashHalfWordMask << objectMemory numTagBits R: destReg;
		AddCq: objectMemory smallIntegerTag R: destReg.
	^0