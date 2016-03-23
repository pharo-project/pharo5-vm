arithmetic integer primitives
primitiveBitOr
	<inline: false>
	<var: 'integerArgumentValue' type: #usqInt>
	<var: 'intergerReceiverValue' type: #usqInt>
	| integerReceiver integerArgument integerArgumentValue integerReceiverValue |
	integerArgument := self stackTop.
	integerReceiver := self stackValue: 1.
	"Note no short-cut for SmallIntegers.  Either the inline interpreter bytecode or the JIT primitive will handle this case."
	integerArgumentValue := self positiveMachineIntegerValueOf: integerArgument.
	integerReceiverValue := self positiveMachineIntegerValueOf: integerReceiver.
	self successful ifTrue:
		[self pop: 2 thenPush: (self positiveMachineIntegerFor: (integerArgumentValue bitOr: integerReceiverValue))]