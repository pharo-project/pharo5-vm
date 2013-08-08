object access primitives
primitiveAsOop
	| thisReceiver |
	thisReceiver := self stackTop.
	self success: (self isIntegerObject: thisReceiver) not.
	self successful
		ifTrue: [self pop:1 thenPushInteger: (self hashBitsOf: thisReceiver)]