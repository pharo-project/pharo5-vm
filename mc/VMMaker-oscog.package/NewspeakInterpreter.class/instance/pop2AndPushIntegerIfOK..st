internal interpreter access
pop2AndPushIntegerIfOK: integerResult

	self successful ifTrue:
		[(self isIntegerValue: integerResult)
			ifTrue: [self pop: 2 thenPush: (self integerObjectOf: integerResult)]
			ifFalse: [self primitiveFail]]