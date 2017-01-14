common selector sends
bytecodePrimPointY

	| rcvr |
	successFlag := true.
	rcvr := self internalStackTop.
	self assertClassOf: rcvr is: (self splObj: ClassPoint).
	successFlag
		ifTrue: [self internalPop: 1 thenPush: (self fetchPointer: YIndex ofObject: rcvr).
			^ self fetchNextBytecode "success"].

	messageSelector := self specialSelector: 31.
	argumentCount := 0.
	self normalSend