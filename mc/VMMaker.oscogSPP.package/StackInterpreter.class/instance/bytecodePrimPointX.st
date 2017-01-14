common selector sends
bytecodePrimPointX

	| rcvr |
	self initPrimCall.
	rcvr := self internalStackTop.
	self assertClassOf: rcvr is: (objectMemory splObj: ClassPoint).
	self successful ifTrue:
		[self internalStackTopPut: (objectMemory fetchPointer: XIndex ofObject: rcvr).
		^self fetchNextBytecode "success"].
	primFailCode := 0.

	messageSelector := self specialSelector: 30.
	argumentCount := 0.
	self normalSend