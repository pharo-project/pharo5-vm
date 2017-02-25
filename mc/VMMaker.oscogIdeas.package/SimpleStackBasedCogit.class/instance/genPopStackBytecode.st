bytecode generators
genPopStackBytecode
	self AddCq: objectMemory wordSize R: SPReg.
	^0