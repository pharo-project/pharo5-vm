stack bytecodes
pushConstantOneBytecode

	self fetchNextBytecode.
	self internalPush: ConstOne.
