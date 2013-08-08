bytecode generators
genPopStackBytecode
	self AddCq: BytesPerWord R: SPReg.
	^0