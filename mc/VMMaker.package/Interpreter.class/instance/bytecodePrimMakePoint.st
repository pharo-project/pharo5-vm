common selector sends
bytecodePrimMakePoint

	successFlag := true.
	self externalizeIPandSP.
	self primitiveMakePoint.
	self internalizeIPandSP.
	successFlag ifTrue: [^ self fetchNextBytecode "success"].

	messageSelector := self specialSelector: 11.
	argumentCount := 1.
	self normalSend