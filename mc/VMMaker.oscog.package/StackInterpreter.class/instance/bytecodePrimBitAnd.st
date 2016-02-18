common selector sends
bytecodePrimBitAnd
	| rcvr arg |
	arg := self internalStackTop.
	rcvr := self internalStackValue: 1.
	((objectMemory isIntegerObject: arg)
	 and: [objectMemory isIntegerObject: rcvr]) ifTrue:
		[self internalPop: 2 thenPush: (arg bitAnd: rcvr).
		 ^self fetchNextBytecode "success"].

	self initPrimCall.
	self externalizeIPandSP.
	self primitiveBitAnd.
	self internalizeIPandSP.
	self successful ifTrue:
		[^self fetchNextBytecode "success"].

	messageSelector := self specialSelector: 14.
	argumentCount := 1.
	self normalSend