stack bytecodes
pushConstantTwoBytecode

	self fetchNextBytecode.
	self internalPush: ConstTwo.
