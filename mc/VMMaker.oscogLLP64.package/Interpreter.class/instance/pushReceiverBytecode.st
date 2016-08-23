stack bytecodes
pushReceiverBytecode

	self fetchNextBytecode.
	self internalPush: receiver.
