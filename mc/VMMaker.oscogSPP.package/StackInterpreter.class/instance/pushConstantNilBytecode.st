stack bytecodes
pushConstantNilBytecode

	self fetchNextBytecode.
	self internalPush: objectMemory nilObject.
