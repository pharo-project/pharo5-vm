arithmetic float primitives
primitiveArctan

	| rcvr |
	<var: #rcvr type: #double>
	rcvr := self popFloat.
	self successful
		ifTrue: [self pushFloat: (self cCode: [rcvr atan]
									inSmalltalk: [rcvr = rcvr
													ifTrue: [rcvr arcTan]
													ifFalse: [Float nan]])]
		ifFalse: [self unPop: 1]