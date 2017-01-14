arithmetic float primitives
primitiveExp
	"Computes E raised to the receiver power."

	| rcvr |
	<var: #rcvr type: #double>
	rcvr := self popFloat.
	self successful
		ifTrue: [self pushFloat: (self cCode: [rcvr exp]
									inSmalltalk: [rcvr = rcvr
													ifTrue: [rcvr exp]
													ifFalse: [Float nan]])]
		ifFalse: [self unPop: 1]