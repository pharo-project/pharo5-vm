common selector sends
bytecodePrimPointY

	| rcvr |
	self initPrimCall.
	rcvr := self internalStackTop.
	self assertClassOf: rcvr is: (objectMemory splObj: ClassPoint).
	self successful ifTrue:
		[self internalStackTopPut: (objectMemory fetchPointer: YIndex ofObject: rcvr).
		^self fetchNextBytecode "success"].
	primFailCode := 0.

	messageSelector := self specialSelector: 31.
	argumentCount := 0.
	self normalSend