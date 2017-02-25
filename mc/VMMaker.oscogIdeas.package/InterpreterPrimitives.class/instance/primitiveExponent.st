arithmetic float primitives
primitiveExponent
	"Exponent part of this float.
	 N.B. IMO we should be able to assume the receiver is a float because this primitive is specific to floats. eem 2/13/2017"
	| rcvr pwr |
	<var: #rcvr type: #double>
	<var: #pwr type: #int>
	rcvr := self stackFloatValue: 0.
	self successful ifTrue:
		["rcvr = frac * 2^pwr, where frac is in [0.5..1.0)"
		 self cCode: [self fr: rcvr exp: (self addressOf: pwr)]
			inSmalltalk: [pwr := rcvr exponent].
		 self stackTopPut: (objectMemory integerObjectOf: pwr - 1)]