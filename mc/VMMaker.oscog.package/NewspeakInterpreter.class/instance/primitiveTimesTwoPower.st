float primitives
primitiveTimesTwoPower
	| rcvr arg |
	<var: #rcvr type: 'double '>
	arg := self popInteger.
	rcvr := self popFloat.
	self successful
		ifTrue: [ self pushFloat: (self cCode: 'ldexp(rcvr, arg)' inSmalltalk: [rcvr timesTwoPower: arg]) ]
		ifFalse: [ self unPop: 2 ].