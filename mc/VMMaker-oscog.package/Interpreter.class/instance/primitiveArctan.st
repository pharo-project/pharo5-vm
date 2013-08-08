arithmetic float primitives
primitiveArctan

	| rcvr |
	<var: #rcvr type: 'double '>
	rcvr := self popFloat.
	successFlag
		ifTrue: [self pushFloat: (self cCode: 'atan(rcvr)' inSmalltalk: [rcvr arcTan])]
		ifFalse: [self unPop: 1]