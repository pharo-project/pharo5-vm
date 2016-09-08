class initialization
initialize
	RootBit ifNil: [ObjectMemory initializeObjectHeaderConstants].
	RootBitDigitLength := RootBit digitLength