float primitives
primitiveTimesTwoPower
	"Computes E raised to the receiver power."
	| rcvr arg twiceMaxExponent result |
	<export: true>
	<var: #rcvr type: #double>
	<var: #result type: #double>
	arg := interpreterProxy stackIntegerValue: 0.
	rcvr := interpreterProxy stackFloatValue: 1.
	interpreterProxy failed ifTrue:
		[^nil].
	((self isFinite: rcvr) and: [rcvr ~= 0.0])
		ifFalse:
			[result := rcvr]
		ifTrue:
			[twiceMaxExponent := 2 * (1 << 11).
			 arg < twiceMaxExponent negated
				ifTrue:
					[result := rcvr < 0.0 ifTrue: [-0.0] ifFalse: [0.0]]
				ifFalse:
					[arg > twiceMaxExponent
						ifTrue:
							[result := rcvr < 0.0 ifTrue: [-1.0e200 / 1.0e-200] ifFalse: [1.0e200 / 1.0e-200]]
						ifFalse:
							[result := self cCode: '__ieee754_ldexp(rcvr, arg)'
											inSmalltalk: [rcvr timesTwoPower: arg]]]].
	(self isnan: result) ifTrue:
		[^interpreterProxy primitiveFail].
	interpreterProxy
		pop: interpreterProxy methodArgumentCount + 1;
		pushFloat: result