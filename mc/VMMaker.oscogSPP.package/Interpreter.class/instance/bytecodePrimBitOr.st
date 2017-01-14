common selector sends
bytecodePrimBitOr

	successFlag := true.
	self externalizeIPandSP.
	self primitiveBitOr.
	self internalizeIPandSP.
	successFlag ifTrue: [^ self fetchNextBytecode "success"].

	messageSelector := self specialSelector: 15.
	argumentCount := 1.
	self normalSend