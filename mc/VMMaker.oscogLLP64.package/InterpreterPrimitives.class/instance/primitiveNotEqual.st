arithmetic integer primitives
primitiveNotEqual
	| integerReceiver integerArgument result |
	integerArgument := self stackTop.
	integerReceiver := self stackValue: 1.
	(objectMemory areIntegers: integerReceiver and: integerArgument)
		ifTrue: [self pop: 2 thenPushBool: integerReceiver ~= integerArgument]
		ifFalse:
			[result := objectMemory hasSixtyFourBitImmediates
						ifTrue:
							[(self signedMachineIntegerValueOf: integerReceiver)
								~= (self signedMachineIntegerValueOf: integerArgument)]
						ifFalse:
							[(self positiveMachineIntegerValueOf: integerReceiver)
								~= (self positiveMachineIntegerValueOf: integerArgument)].
			 self successful ifTrue:
				[self pop: 2 thenPushBool: result]]