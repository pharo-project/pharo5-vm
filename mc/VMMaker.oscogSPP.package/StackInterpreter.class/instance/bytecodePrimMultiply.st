common selector sends
bytecodePrimMultiply
	| rcvr arg result overflow oop |
	rcvr := self internalStackValue: 1.
	arg := self internalStackValue: 0.
	(objectMemory areIntegers: rcvr and: arg)
		ifTrue: [rcvr := objectMemory integerValueOf: rcvr.
				arg := objectMemory integerValueOf: arg.
				overflow := rcvr > 0
							ifTrue:  [arg > 0
								ifTrue: [rcvr > (objectMemory maxSmallInteger / arg)]
								ifFalse: [arg < (objectMemory minSmallInteger / rcvr)]]
							ifFalse: [arg > 0
								ifTrue: [rcvr < (objectMemory minSmallInteger / arg)]
								ifFalse: [(rcvr < 0) and: [arg < (objectMemory maxSmallInteger / rcvr)]]].
				overflow
					ifFalse:
						[result := rcvr * arg.
						oop := objectMemory integerObjectOf: result.
      					self internalPop: 2 thenPush: oop.
						^self fetchNextBytecode "success"]]
		ifFalse: [self initPrimCall.
				self externalizeIPandSP.
				self primitiveFloatMultiply: rcvr byArg: arg.
				self internalizeIPandSP.
				self successful ifTrue: [^ self fetchNextBytecode "success"]].

	messageSelector := self specialSelector: 8.
	argumentCount := 1.
	self normalSend