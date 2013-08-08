common selector sends
bytecodePrimPointY

	| rcvr |
	self initPrimCall.
	rcvr := self internalStackTop.
	self assertClassOf: rcvr is: (self splObj: ClassPoint).
	self successful
		ifTrue: [self internalPop: 1 thenPush: (self fetchPointer: YIndex ofObject: rcvr).
			^ self fetchNextBytecode "success"].

	messageSelector := self specialSelector: 31.
	argumentCount := 0.
	self normalSend