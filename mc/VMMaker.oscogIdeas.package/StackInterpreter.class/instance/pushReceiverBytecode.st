stack bytecodes
pushReceiverBytecode

	self fetchNextBytecode.
	self internalPush: self receiver.
