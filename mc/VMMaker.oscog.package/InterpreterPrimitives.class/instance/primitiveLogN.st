arithmetic float primitives
primitiveLogN
	"Natural log."

	| rcvr |
	<var: #rcvr type: #double>
	rcvr := self popFloat.
	self successful
		ifTrue: [self pushFloat: (self cCode: [rcvr log]
									inSmalltalk: [rcvr = rcvr
													ifTrue: [rcvr ln]
													ifFalse: [Float nan]])]
		ifFalse: [self unPop: 1]