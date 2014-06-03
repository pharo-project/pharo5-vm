arithmetic integer primitives
primitiveBitOr
	| integerReceiver integerArgument |
	integerArgument := self popPos32BitInteger.
	integerReceiver := self popPos32BitInteger.
	successFlag
		ifTrue: [self push: (self positive32BitIntegerFor:
					(integerReceiver bitOr: integerArgument))]
		ifFalse: [self unPop: 2]