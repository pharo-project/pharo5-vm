stack bytecodes
pushConstantFalseBytecode

	self fetchNextBytecode.
	self internalPush: objectMemory falseObject.
