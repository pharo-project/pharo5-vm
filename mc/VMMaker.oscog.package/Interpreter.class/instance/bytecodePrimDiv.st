common selector sends
bytecodePrimDiv
	| quotient |
	successFlag := true.
	quotient := self doPrimitiveDiv: (self internalStackValue: 1) by: (self internalStackValue: 0).
	successFlag ifTrue: [self internalPop: 2 thenPush: (self integerObjectOf: quotient).
		^ self fetchNextBytecode "success"].

	messageSelector := self specialSelector: 13.
	argumentCount := 1.
	self normalSend