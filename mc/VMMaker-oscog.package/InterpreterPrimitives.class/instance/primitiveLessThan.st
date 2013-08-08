arithmetic integer primitives
primitiveLessThan
	| integerReceiver integerArgument |
	integerArgument := self popInteger.
	integerReceiver := self popInteger.
	self checkBooleanResult: integerReceiver < integerArgument