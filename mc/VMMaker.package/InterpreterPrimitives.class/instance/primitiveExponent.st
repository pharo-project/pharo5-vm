arithmetic float primitives
primitiveExponent
	"Exponent part of this float."

	| rcvr frac pwr |
	<var: #rcvr type: #double>
	<var: #frac type: #double>
	<var: #pwr type: #int>
	rcvr := self popFloat.
	self successful
		ifTrue: [  "rcvr = frac * 2^pwr, where frac is in [0.5..1.0)"
			self cCode: 'frac = frexp(rcvr, &pwr)'
					inSmalltalk: [pwr := rcvr exponent].
			self pushInteger: pwr - 1]
		ifFalse: [self unPop: 1]