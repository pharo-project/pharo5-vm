arithmetic integer primitives
primitiveGreaterThan
	| integerReceiver integerArgument |
	integerArgument := self stackTop.
	integerReceiver := self stackValue: 1.
	(objectMemory areIntegers: integerReceiver and: integerArgument)
		ifTrue: [self cCode: '' inSmalltalk:
					[integerReceiver := objectMemory integerValueOf: integerReceiver.
					 integerArgument := objectMemory integerValueOf: integerArgument].
				self pop: 2 thenPushBool: integerReceiver > integerArgument]
		ifFalse: [self primitiveFail]