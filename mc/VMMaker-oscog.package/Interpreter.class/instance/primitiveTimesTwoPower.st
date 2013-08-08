arithmetic float primitives
primitiveTimesTwoPower
	| rcvr arg |
	<var: #rcvr type: 'double '>
	arg := self popInteger.
	rcvr := self popFloat.
	successFlag
		ifTrue: [ self pushFloat: (self cCode: 'ldexp(rcvr, arg)' inSmalltalk: [rcvr timesTwoPower: arg]) ]
		ifFalse: [ self unPop: 2 ].