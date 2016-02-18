common selector sends
bytecodePrimBitOr
	| rcvr arg |
	arg := self internalStackTop.
	rcvr := self internalStackValue: 1.
	((objectMemory isIntegerObject: arg)
	 and: [objectMemory isIntegerObject: rcvr]) ifTrue:
		[self internalPop: 2 thenPush: (arg bitOr: rcvr).
		 ^self fetchNextBytecode "success"].

	self initPrimCall.
	self externalizeIPandSP.
	self primitiveBitOr.
	self internalizeIPandSP.
	self successful ifTrue:
		[^self fetchNextBytecode "success"].

	messageSelector := self specialSelector: 15.
	argumentCount := 1.
	self normalSend