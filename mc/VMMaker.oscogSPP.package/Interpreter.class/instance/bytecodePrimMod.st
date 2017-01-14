common selector sends
bytecodePrimMod
	| mod |
	successFlag := true.
	mod := self doPrimitiveMod: (self internalStackValue: 1) by: (self internalStackValue: 0).
	successFlag ifTrue:
		[self internalPop: 2 thenPush: (self integerObjectOf: mod).
		^ self fetchNextBytecode "success"].

	messageSelector := self specialSelector: 10.
	argumentCount := 1.
	self normalSend