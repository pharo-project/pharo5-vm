arithmetic float primitives
primitiveSquareRoot
	"N.B. IMO we should be able to assume the receiver is a float because this primitive is specific to floats. eem 2/13/2017"
	| rcvr |
	<var: #rcvr type: #double>
	rcvr := self stackFloatValue: 0.
	(self successful and: [rcvr >= 0.0])
		ifTrue: [self stackTopPut: (objectMemory floatObjectOf: rcvr sqrt)]
		ifFalse: [self primitiveFail]