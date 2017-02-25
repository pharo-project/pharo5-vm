arithmetic float primitives
primitiveFractionalPart
	"Fractional part of this float.
	 N.B. IMO we should be able to assume the receiver is a float because this primitive is specific to floats. eem 2/13/2017"
	| rcvr trunc |
	<var: #rcvr type: #double>
	<var: #trunc type: #double>
	rcvr := self stackFloatValue: 0.
	self successful ifTrue:
		[self stackTopPut: (objectMemory floatObjectOf:
							(self cCode: [self mod: rcvr f: (self addressOf: trunc)]
								inSmalltalk: [rcvr fractionPart]))]