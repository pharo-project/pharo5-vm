arithmetic float primitives
primitiveArctan
	"N.B. IMO we should be able to assume the receiver is a float because this primitive is specific to floats. eem 2/13/2017"
	| rcvr |
	<var: #rcvr type: #double>
	rcvr := self stackFloatValue: 0.
	self successful ifTrue:
		[self stackTopPut: (objectMemory floatObjectOf:
								(self cCode: [rcvr atan]
									inSmalltalk: [rcvr = rcvr
													ifTrue: [rcvr arcTan]
													ifFalse: [Float nan]]))]