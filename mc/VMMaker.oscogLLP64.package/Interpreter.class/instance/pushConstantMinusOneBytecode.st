stack bytecodes
pushConstantMinusOneBytecode

	self fetchNextBytecode.
	self internalPush: ConstMinusOne.
