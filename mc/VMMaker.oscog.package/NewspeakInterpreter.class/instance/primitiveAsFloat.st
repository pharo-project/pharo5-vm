float primitives
primitiveAsFloat
	| arg |
	arg := self popInteger.
	self successful
		ifTrue: [self pushFloat: arg asFloat]
		ifFalse: [self unPop: 1]