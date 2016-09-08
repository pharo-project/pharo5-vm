float primitives
primitiveFractionalPart
	"Computes receiver \\ 1.0"
	| rcvr result trunc |
	<export: true>
	<var: #rcvr type: 'double'>
	<var: #result type: 'double'>
	<var: #trunc type: 'double'>
	rcvr := interpreterProxy stackFloatValue: 0.
	(interpreterProxy failed) ifTrue:[^nil].
	result := self cCode: '__ieee754_modf(rcvr, &trunc)' inSmalltalk: [rcvr fractionPart].
	(self isnan: result) ifTrue:[^interpreterProxy primitiveFail].
	interpreterProxy pop: interpreterProxy methodArgumentCount + 1.
	interpreterProxy pushFloat: result.