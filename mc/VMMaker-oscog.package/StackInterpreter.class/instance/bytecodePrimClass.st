common selector sends
bytecodePrimClass
	| rcvr |
	rcvr := self internalStackTop.
	self internalStackTopPut: (objectMemory fetchClassOf: rcvr).
	self fetchNextBytecode