common selector sends
bytecodePrimAdd
	| rcvr arg result |
	rcvr := self internalStackValue: 1.
	arg := self internalStackValue: 0.
	(objectMemory areIntegers: rcvr and: arg)
		ifTrue: [result := (objectMemory integerValueOf: rcvr) + (objectMemory integerValueOf: arg).
				(objectMemory isIntegerValue: result) ifTrue:
					[self internalPop: 2 thenPush: (objectMemory integerObjectOf: result).
					^ self fetchNextBytecode "success"]]
		ifFalse: [self initPrimCall.
				self externalizeIPandSP.
				self primitiveFloatAdd: rcvr toArg: arg.
				self internalizeIPandSP.
				self successful ifTrue: [^ self fetchNextBytecode "success"]].

	messageSelector := self specialSelector: 0.
	argumentCount := 1.
	self normalSend