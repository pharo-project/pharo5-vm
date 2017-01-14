float primitives
primitiveHypot
	"hypot(x,y) returns sqrt(x^2+y^2) with error less  than 1 ulps"
	| rcvr arg result |
	<export: true>
	<var: #rcvr type: 'double'>
	<var: #arg type: 'double'>
	<var: #result type: 'double'>
	arg := interpreterProxy stackFloatValue: 0.
	rcvr := interpreterProxy stackFloatValue: 1.
	(interpreterProxy failed) ifTrue:[^nil].
	result := self cCode: '__ieee754_hypot(rcvr, arg)' inSmalltalk: [rcvr hypot: arg].
	(self isnan: result) ifTrue:[^interpreterProxy primitiveFail].
	interpreterProxy pop: interpreterProxy methodArgumentCount + 1.
	interpreterProxy pushFloat: result.