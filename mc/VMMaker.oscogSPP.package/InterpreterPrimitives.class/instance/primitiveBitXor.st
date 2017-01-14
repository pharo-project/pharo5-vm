arithmetic integer primitives
primitiveBitXor
	<inline: false>
	<var: 'integerArgumentValue' type: #usqInt>
	<var: 'integerReceiverValue' type: #usqInt>
	| integerReceiver integerArgument integerArgumentValue integerReceiverValue |
	integerArgument := self stackTop.
	integerReceiver := self stackValue: 1.
	((objectMemory isIntegerObject: integerArgument)
	 and: [objectMemory isIntegerObject: integerReceiver])
		ifTrue: "xoring will leave the tag bits zero, whether the tag is 1 or zero, so add it back in."
			[self pop: 2 thenPush: (integerArgument bitXor: integerReceiver) + objectMemory smallIntegerTag]
		ifFalse:
			[integerArgumentValue := self positiveMachineIntegerValueOf: integerArgument.
			integerReceiverValue := self positiveMachineIntegerValueOf: integerReceiver.
			 self successful ifTrue:
				[self pop: 2 thenPush: (self positiveMachineIntegerFor: (integerArgumentValue bitXor: integerReceiverValue))]]