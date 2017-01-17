float primitives
primitiveArcSin
	"Computes asin(receiver)"
	| rcvr result |
	<export: true>
	<var: #rcvr type: 'double'>
	<var: #result type: 'double'>
	rcvr := interpreterProxy stackFloatValue: 0.
	(interpreterProxy failed) ifTrue:[^nil].
	result := self cCode: '__ieee754_asin(rcvr)' inSmalltalk: [rcvr arcSin].
	(self isnan: result) ifTrue:[^interpreterProxy primitiveFail].
	interpreterProxy pop: interpreterProxy methodArgumentCount + 1.
	interpreterProxy pushFloat: result.