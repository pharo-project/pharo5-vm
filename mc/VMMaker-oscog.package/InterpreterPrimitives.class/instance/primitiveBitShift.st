arithmetic integer primitives
primitiveBitShift 
	| integerReceiver integerArgument shifted |
	integerArgument := self popInteger.
	integerReceiver := self popPos32BitInteger.
	self successful ifTrue: [
		integerArgument >= 0 ifTrue: [
			"Left shift -- must fail if we lose bits beyond 32"
			self success: integerArgument <= 31.
			shifted := integerReceiver << integerArgument.
			self success: (shifted >> integerArgument) = integerReceiver.
		] ifFalse: [
			"Right shift -- OK to lose bits"
			self success: integerArgument >= -31.
			shifted := integerReceiver >> (0 - integerArgument).
		].
	].
	self successful
		ifTrue: [self push: (self positive32BitIntegerFor: shifted)]
		ifFalse: [self unPop: 2]