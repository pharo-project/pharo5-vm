arithmetic integer primitives
primitiveMultiply
	| integerRcvr integerArg integerResult overflow |
	integerRcvr := self stackIntegerValue: 1.
	integerArg := self stackIntegerValue: 0.
	self successful ifTrue:
		[overflow := integerRcvr > 0
					ifTrue:  [integerArg > 0
						ifTrue: [integerRcvr > (objectMemory maxSmallInteger / integerArg)]
						ifFalse: [integerArg < (objectMemory minSmallInteger / integerRcvr)]]
					ifFalse: [integerArg > 0
						ifTrue: [integerRcvr < (objectMemory minSmallInteger / integerArg)]
						ifFalse: [(integerRcvr < 0) and: [integerArg < (objectMemory maxSmallInteger / integerRcvr)]]].
		overflow
			ifTrue: [self primitiveFail]
			ifFalse:
				[integerResult := integerRcvr * integerArg.
				self pop: 2 thenPush: (objectMemory integerObjectOf: integerResult)]]