stack bytecodes
duplicateTopBytecode

	self fetchNextBytecode.
	self internalPush: self internalStackTop.
