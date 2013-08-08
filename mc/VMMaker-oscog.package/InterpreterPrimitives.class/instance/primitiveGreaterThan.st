arithmetic integer primitives
primitiveGreaterThan
	| integerReceiver integerArgument |
	integerArgument := self popInteger.
	integerReceiver := self popInteger.
	self checkBooleanResult: integerReceiver > integerArgument