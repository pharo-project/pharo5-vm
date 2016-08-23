stack bytecodes
pushConstantNilBytecode

	self fetchNextBytecode.
	self internalPush: nilObj.
