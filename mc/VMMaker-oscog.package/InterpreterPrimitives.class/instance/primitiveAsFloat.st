arithmetic float primitives
primitiveAsFloat
	| arg |
	arg := self popInteger.
	self successful
		ifTrue: [ self pushFloat: (self cCode: '((double) arg)' inSmalltalk: [arg asFloat]) ]
		ifFalse: [ self unPop: 1 ]