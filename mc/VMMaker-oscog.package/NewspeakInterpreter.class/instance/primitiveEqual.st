arithmetic primitives
primitiveEqual
	| integerReceiver integerArgument result |
	integerArgument := self popStack.
	integerReceiver := self popStack.
	result := self compare31or32Bits: integerReceiver equal: integerArgument.
	self checkBooleanResult: result