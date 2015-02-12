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
			[objectMemory wordSize = 8
				ifTrue:
					[integerArgument := self positive64BitValueOf: integerArgument.
					 integerReceiver := self positive64BitValueOf: integerReceiver.
					 self successful ifTrue:
						[self pop: 2 thenPush: (self positive64BitIntegerFor: (integerArgument bitXor: integerReceiver))]]
				ifFalse:
					[integerArgument := self positive32BitValueOf: integerArgument.
					 integerReceiver := self positive32BitValueOf: integerReceiver.
					 self successful ifTrue:
						[self pop: 2 thenPush: (self positive32BitIntegerFor: (integerArgument bitXor: integerReceiver))]]]