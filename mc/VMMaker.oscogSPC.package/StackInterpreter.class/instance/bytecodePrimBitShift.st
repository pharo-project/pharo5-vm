common selector sends
bytecodePrimBitShift

	self initPrimCall.
	self externalizeIPandSP.
	self primitiveBitShift.
	self internalizeIPandSP.
	self successful ifTrue: [^ self fetchNextBytecode "success"].

	messageSelector := self specialSelector: 12.
	argumentCount := 1.
	self normalSend