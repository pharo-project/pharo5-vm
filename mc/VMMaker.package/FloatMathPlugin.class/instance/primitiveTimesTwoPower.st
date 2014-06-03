float primitives
primitiveTimesTwoPower
	"Computes E raised to the receiver power."
	| rcvr arg result |
	<export: true>
	<var: #rcvr type: 'double'>
	<var: #result type: 'double'>
	arg := interpreterProxy stackIntegerValue: 0.
	rcvr := interpreterProxy stackFloatValue: 1.
	(interpreterProxy failed) ifTrue:[^nil].
	result := self cCode: '__ieee754_ldexp(rcvr, arg)' inSmalltalk: [rcvr timesTwoPower: arg].
	(self isnan: result) ifTrue:[^interpreterProxy primitiveFail].
	interpreterProxy pop: interpreterProxy methodArgumentCount + 1.
	interpreterProxy pushFloat: result.