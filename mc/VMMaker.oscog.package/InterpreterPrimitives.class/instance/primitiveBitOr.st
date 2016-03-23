arithmetic integer primitives
primitiveBitOr
	<inline: false>
	<var: 'integerArgumentValue' type: #usqInt>
	<var: 'intergerReceiverValue' type: #usqInt>
	| integerReceiver integerArgument integerArgumentValue integerReceiverValue |
	integerArgument := self stackTop.
	integerReceiver := self stackValue: 1.
	"Comment out the short-cut.  Either the inline interpreter bytecode or the JIT primitive will handle this case.
	 ((objectMemory isIntegerObject: integerArgument)
	 and: [objectMemory isIntegerObject: integerReceiver])
		ifTrue: [self pop: 2 thenPush: (integerArgument bitOr: integerReceiver)]
		ifFalse:
			["
			integerArgumentValue := self positiveMachineIntegerValueOf: integerArgument.
			integerReceiverValue := self positiveMachineIntegerValueOf: integerReceiver.
			self successful ifTrue:
					[self pop: 2 thenPush: (self positiveMachineIntegerFor: (integerArgumentValue bitOr: integerReceiverValue))]
				ifFalse:
					[]"]"