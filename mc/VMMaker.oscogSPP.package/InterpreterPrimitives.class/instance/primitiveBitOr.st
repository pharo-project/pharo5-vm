arithmetic integer primitives
primitiveBitOr
	<inline: false>
	<var: 'integerArgumentValue' type: #usqInt>
	<var: 'integerReceiverValue' type: #usqInt>
	| integerArgumentValue integerReceiverValue |
	"Note no short-cut for SmallIntegers.  Either the inline interpreter bytecode or the JIT primitive will handle this case."
	integerArgumentValue := self positiveMachineIntegerValueOf: self stackTop.
	integerReceiverValue := self positiveMachineIntegerValueOf: (self stackValue: 1).
	self successful ifTrue:
		[self pop: 2 thenPush: (self positiveMachineIntegerFor: (integerArgumentValue bitOr: integerReceiverValue))]