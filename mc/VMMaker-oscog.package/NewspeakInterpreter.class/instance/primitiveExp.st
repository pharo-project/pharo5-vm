float primitives
primitiveExp
	"Computes E raised to the receiver power."

	| rcvr |
	<var: #rcvr type: 'double '>
	rcvr := self popFloat.
	self successful
		ifTrue: [self pushFloat: (self cCode: 'exp(rcvr)' inSmalltalk: [rcvr exp])]
		ifFalse: [self unPop: 1]