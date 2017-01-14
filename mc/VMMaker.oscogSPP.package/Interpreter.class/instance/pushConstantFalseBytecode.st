stack bytecodes
pushConstantFalseBytecode

	self fetchNextBytecode.
	self internalPush: falseObj.
