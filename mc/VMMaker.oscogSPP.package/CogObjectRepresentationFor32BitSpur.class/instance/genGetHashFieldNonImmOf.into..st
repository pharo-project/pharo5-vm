compile abstract instructions
genGetHashFieldNonImmOf: instReg into: destReg
	"Fetch the instance's identity hash into destReg, unencoded."
	cogit MoveMw: 4 r: instReg R: destReg.
	cogit AndCq: objectMemory identityHashHalfWordMask R: destReg.
	^0