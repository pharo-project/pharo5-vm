compile abstract instructions
genGetClassObjectOfNonCompact: instReg into: destReg
	cogit
		MoveMw: objectMemory classFieldOffset r: instReg R: destReg;
		AndCq: AllButTypeMask signedIntFromLong R: destReg.
	^0