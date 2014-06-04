common selector sends
bytecodePrimMod
	| mod |
	self initPrimCall.
	mod := self doPrimitiveMod: (self internalStackValue: 1) by: (self internalStackValue: 0).
	self successful ifTrue:
		[self internalPop: 2 thenPush: (objectMemory integerObjectOf: mod).
		^ self fetchNextBytecode "success"].

	messageSelector := self specialSelector: 10.
	argumentCount := 1.
	self normalSend