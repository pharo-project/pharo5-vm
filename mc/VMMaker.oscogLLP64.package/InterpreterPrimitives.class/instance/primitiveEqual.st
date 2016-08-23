arithmetic integer primitives
primitiveEqual
	| integerReceiver integerArgument result |
	integerArgument := self stackTop.
	integerReceiver := self stackValue: 1.
	(objectMemory areIntegers: integerReceiver and: integerArgument)
		ifTrue: [self pop: 2 thenPushBool: integerReceiver = integerArgument]
		ifFalse:
			[result := objectMemory hasSixtyFourBitImmediates
						ifTrue:
							[(self signed64BitValueOf: integerReceiver)
								= (self signed64BitValueOf: integerArgument)]
						ifFalse:
							[(self positiveMachineIntegerValueOf: integerReceiver)
								= (self positiveMachineIntegerValueOf: integerArgument)].
			 self successful ifTrue:
				[self pop: 2 thenPushBool: result]]