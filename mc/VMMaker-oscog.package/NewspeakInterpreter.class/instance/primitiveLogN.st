float primitives
primitiveLogN
	"Natural log."

	| rcvr |
	<var: #rcvr type: 'double '>
	rcvr := self popFloat.
	self successful
		ifTrue: [self pushFloat: (self cCode: 'log(rcvr)' inSmalltalk: [rcvr ln])]
		ifFalse: [self unPop: 1]