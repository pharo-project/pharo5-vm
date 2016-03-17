arithmetic integer primitives
primitiveBitAnd
	<inline: false>
	<var: 'integerArgument' type: #usqInt>
	<var: 'intergerReceiver' type: #usqInt>
	| integerReceiver integerArgument |
	integerArgument := self stackTop.
	integerReceiver := self stackValue: 1.
	"Comment out the short-cut.  Either the inline interpreter bytecode or the JIT primitive will handle this case.
	 ((objectMemory isIntegerObject: integerArgument)
	 and: [objectMemory isIntegerObject: integerReceiver])
		ifTrue: [self pop: 2 thenPush: (integerArgument bitAnd: integerReceiver)]
		ifFalse:
			["
			integerArgument := self positiveMachineIntegerValueOf: integerArgument.
			integerReceiver := self positiveMachineIntegerValueOf: integerReceiver.
			self successful ifTrue:
					[self pop: 2 thenPush: (self positiveMachineIntegerFor: (integerArgument bitAnd: integerReceiver))]
				ifFalse:
					[]"]"