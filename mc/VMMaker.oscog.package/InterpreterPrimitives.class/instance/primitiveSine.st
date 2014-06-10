arithmetic float primitives
primitiveSine

	| rcvr |
	<var: #rcvr type: #double>
	rcvr := self popFloat.
	self successful
		ifTrue: [self pushFloat: (self cCode: [rcvr sin]
									inSmalltalk: [rcvr = rcvr
													ifTrue: [rcvr sin]
													ifFalse: [Float nan]])]
		ifFalse: [self unPop: 1]