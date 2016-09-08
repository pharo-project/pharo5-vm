contexts
pop2AndPushIntegerIfOK: integerResult

	successFlag ifTrue:
		[(self isIntegerValue: integerResult)
			ifTrue: [self pop: 2 thenPush: (self integerObjectOf: integerResult)]
			ifFalse: [successFlag := false]]