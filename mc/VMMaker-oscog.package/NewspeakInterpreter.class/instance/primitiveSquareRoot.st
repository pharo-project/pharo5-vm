float primitives
primitiveSquareRoot
	| rcvr |
	<var: #rcvr type: 'double '>
	rcvr := self popFloat.
	self success: rcvr >= 0.0.
	self successful
		ifTrue: [self pushFloat: (self cCode: 'sqrt(rcvr)' inSmalltalk: [rcvr sqrt])]
		ifFalse: [self unPop: 1]