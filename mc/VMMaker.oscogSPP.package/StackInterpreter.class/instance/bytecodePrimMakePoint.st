common selector sends
bytecodePrimMakePoint

	self initPrimCall.
	self externalizeIPandSP.
	self primitiveMakePoint.
	self internalizeIPandSP.
	self successful ifTrue: [^ self fetchNextBytecode "success"].

	messageSelector := self specialSelector: 11.
	argumentCount := 1.
	self normalSend