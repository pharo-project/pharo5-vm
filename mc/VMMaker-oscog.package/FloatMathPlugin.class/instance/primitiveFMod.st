float primitives
primitiveFMod
	"Computes receiver \\ arg"
	| rcvr arg result |
	<export: true>
	<var: #rcvr type: 'double'>
	<var: #arg type: 'double'>
	<var: #result type: 'double'>
	arg := interpreterProxy stackFloatValue: 0.
	rcvr := interpreterProxy stackFloatValue: 1.
	(interpreterProxy failed) ifTrue:[^nil].
	result := self cCode: '__ieee754_fmod(rcvr, arg)' inSmalltalk: [rcvr \\ arg].
	(self isnan: result) ifTrue:[^interpreterProxy primitiveFail].
	interpreterProxy pop: interpreterProxy methodArgumentCount + 1.
	interpreterProxy pushFloat: result.