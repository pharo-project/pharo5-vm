common selector sends
bytecodePrimBitAnd

	self initPrimCall.
	self externalizeIPandSP.
	self primitiveBitAnd.
	self internalizeIPandSP.
	self successful ifTrue: [^ self fetchNextBytecode "success"].

	messageSelector := self specialSelector: 14.
	argumentCount := 1.
	self normalSend