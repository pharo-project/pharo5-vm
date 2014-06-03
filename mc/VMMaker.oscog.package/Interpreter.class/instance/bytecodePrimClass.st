common selector sends
bytecodePrimClass
	| rcvr |
	rcvr := self internalStackTop.
	self internalPop: 1 thenPush: (self fetchClassOf: rcvr).
	self fetchNextBytecode.
