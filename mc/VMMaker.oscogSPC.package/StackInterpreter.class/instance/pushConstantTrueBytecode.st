stack bytecodes
pushConstantTrueBytecode

	self fetchNextBytecode.
	self internalPush: objectMemory trueObject.
