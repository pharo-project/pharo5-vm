compile abstract instructions
genGetHashFieldNonImmOf: instReg into: destReg
	"Fetch the instance's identity hash into destReg, unencoded."
	cogit
		MoveMw: 0 r: instReg R: destReg;
		LogicalShiftRightCq: 32 R: destReg;
		AndCq: objectMemory identityHashHalfWordMask R: destReg.
	^0