float primitives
primitiveSine

	| rcvr |
	<var: #rcvr type: 'double '>
	rcvr := self popFloat.
	self successful
		ifTrue: [self pushFloat: (self cCode: 'sin(rcvr)' inSmalltalk: [rcvr sin])]
		ifFalse: [self unPop: 1]