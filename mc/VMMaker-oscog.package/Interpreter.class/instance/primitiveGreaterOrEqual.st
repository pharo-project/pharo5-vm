arithmetic integer primitives
primitiveGreaterOrEqual
	| integerReceiver integerArgument |
	integerArgument := self popInteger.
	integerReceiver := self popInteger.
	self checkBooleanResult: integerReceiver >= integerArgument