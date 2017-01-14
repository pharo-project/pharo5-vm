common selector sends
bytecodePrimBitShift

	successFlag := true.
	self externalizeIPandSP.
	self primitiveBitShift.
	self internalizeIPandSP.
	successFlag ifTrue: [^ self fetchNextBytecode "success"].

	messageSelector := self specialSelector: 12.
	argumentCount := 1.
	self normalSend