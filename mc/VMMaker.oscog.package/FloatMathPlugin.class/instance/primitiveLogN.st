float primitives
primitiveLogN
	"Computes log(receiver)"
	| rcvr result |
	<export: true>
	<var: #rcvr type: 'double'>
	<var: #result type: 'double'>
	rcvr := interpreterProxy stackFloatValue: 0.
	(interpreterProxy failed) ifTrue:[^nil].
	rcvr < 0.0 ifTrue:[^interpreterProxy primitiveFail].
	result := self cCode: '__ieee754_log(rcvr)' inSmalltalk: [rcvr ln].
	(self isnan: result) ifTrue:[^interpreterProxy primitiveFail].
	interpreterProxy pop: interpreterProxy methodArgumentCount + 1.
	interpreterProxy pushFloat: result.