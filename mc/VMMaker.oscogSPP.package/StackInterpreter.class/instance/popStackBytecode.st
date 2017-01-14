stack bytecodes
popStackBytecode

	self fetchNextBytecode.
	self internalPop: 1.
