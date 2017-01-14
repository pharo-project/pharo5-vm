stack bytecodes
pushConstantTrueBytecode

	self fetchNextBytecode.
	self internalPush: trueObj.
