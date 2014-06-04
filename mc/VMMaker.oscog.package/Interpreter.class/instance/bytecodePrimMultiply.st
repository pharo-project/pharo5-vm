common selector sends
bytecodePrimMultiply
	| rcvr arg result |
	rcvr := self internalStackValue: 1.
	arg := self internalStackValue: 0.
	(self areIntegers: rcvr and: arg)
		ifTrue: [rcvr := self integerValueOf: rcvr.
				arg := self integerValueOf: arg.
				result := rcvr * arg.
				(arg = 0
				 or: [(result // arg) = rcvr and: [self isIntegerValue: result]]) ifTrue:
					[self internalPop: 2 thenPush: (self integerObjectOf: result).
					 ^self fetchNextBytecode "success"]]
		ifFalse: [successFlag := true.
				self externalizeIPandSP.
				self primitiveFloatMultiply: rcvr byArg: arg.
				self internalizeIPandSP.
				successFlag ifTrue: [^ self fetchNextBytecode "success"]].

	messageSelector := self specialSelector: 8.
	argumentCount := 1.
	self normalSend.
