common selector sends
bytecodePrimClass
	| rcvr |
	rcvr := self internalStackTop.
	(objectMemory isOopForwarded: rcvr) ifTrue:
		[rcvr := self handleSpecialSelectorSendFaultFor: rcvr].
	self internalStackTopPut: (objectMemory fetchClassOf: rcvr).
	self fetchNextBytecode