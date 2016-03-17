arithmetic integer primitives
primitiveBitXor
	<inline: false>
	| integerReceiver integerArgument |
	integerArgument := self stackTop.
	integerReceiver := self stackValue: 1.
	((objectMemory isIntegerObject: integerArgument)
	 and: [objectMemory isIntegerObject: integerReceiver])
		ifTrue: "xoring will leave the tag bits zero, whether the tag is 1 or zero, so add it back in."
			[self pop: 2 thenPush: (integerArgument bitXor: integerReceiver) + objectMemory smallIntegerTag]
		ifFalse:
			[integerArgument := self positiveMachineIntegerValueOf: integerArgument.
			 integerReceiver := self positiveMachineIntegerValueOf: integerReceiver.
			 self successful ifTrue:
				[self pop: 2 thenPush: (self positiveMachineIntegerFor: (integerArgument bitXor: integerReceiver))]]