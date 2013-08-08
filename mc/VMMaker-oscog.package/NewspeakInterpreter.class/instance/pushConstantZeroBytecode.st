stack bytecodes
pushConstantZeroBytecode

	self fetchNextBytecode.
	self internalPush: ConstZero.
