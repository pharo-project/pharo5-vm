float primitives
primitiveTimesTwoPower
	"Multiply the receiver by the power of the argument."
	| rcvr arg result |
	<export: true>
	<var: #rcvr type: #double>
	<var: #result type: #double>
	arg := interpreterProxy stackIntegerValue: 0.
	rcvr := interpreterProxy stackFloatValue: 1.
	interpreterProxy failed ifTrue:
		[^nil].
	interpreterProxy bytesPerOop > 4 ifTrue:
		[| twiceMaxExponent | "clip arg to at most int range; ldexp's last arg is of type int"
		 twiceMaxExponent := 2 * (1 << self floatExponentBits).
	 	 arg < twiceMaxExponent negated
			ifTrue: [arg := twiceMaxExponent negated]
			ifFalse: [arg > twiceMaxExponent ifTrue:
						[arg := twiceMaxExponent]]].
	result := self cCode: '__ieee754_ldexp(rcvr, (int)arg)'
					inSmalltalk: [rcvr timesTwoPower: arg].
	(self isnan: result) ifFalse:
		[interpreterProxy methodReturnValue: (interpreterProxy floatObjectOf: result)].
	^nil