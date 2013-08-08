common selector sends
bytecodePrimMultiply
	| rcvr arg result |
	rcvr := self internalStackValue: 1.
	arg := self internalStackValue: 0.
	(self areIntegers: rcvr and: arg)
		ifTrue: [rcvr := objectMemory integerValueOf: rcvr.
				arg := objectMemory integerValueOf: arg.
				result := rcvr * arg.
				(arg = 0
				 or: [(result // arg) = rcvr and: [objectMemory isIntegerValue: result]]) ifTrue:
					[self internalPop: 2 thenPush: (objectMemory integerObjectOf: result).
					 ^self fetchNextBytecode "success"]]
		ifFalse: [self initPrimCall.
				self externalizeIPandSP.
				self primitiveFloatMultiply: rcvr byArg: arg.
				self internalizeIPandSP.
				self successful ifTrue: [^ self fetchNextBytecode "success"]].

	messageSelector := self specialSelector: 8.
	argumentCount := 1.
	self normalSend