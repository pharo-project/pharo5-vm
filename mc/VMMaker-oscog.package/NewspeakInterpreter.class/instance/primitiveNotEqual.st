arithmetic primitives
primitiveNotEqual
	| integerReceiver integerArgument result |
	integerArgument := self popStack.
	integerReceiver := self popStack.
	result := (self compare31or32Bits: integerReceiver equal: integerArgument) not.
	self checkBooleanResult: result