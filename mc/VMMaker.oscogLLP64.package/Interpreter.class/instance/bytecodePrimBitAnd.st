common selector sends
bytecodePrimBitAnd

	successFlag := true.
	self externalizeIPandSP.
	self primitiveBitAnd.
	self internalizeIPandSP.
	successFlag ifTrue: [^ self fetchNextBytecode "success"].

	messageSelector := self specialSelector: 14.
	argumentCount := 1.
	self normalSend