arithmetic primitives
primitiveMulScalar
	"Primitive. Add the argument, a scalar value to the receiver, a FloatArray"
	| rcvr rcvrPtr value length |
	<export: true>
	<var: #value type: #double>
	<var: #rcvrPtr type:#'float *'>
	value := interpreterProxy stackFloatValue: 0.
	interpreterProxy failed ifTrue:[^nil].
	rcvr := interpreterProxy stackValue: 1.
	(interpreterProxy isWords: rcvr) ifFalse:
		[^interpreterProxy primitiveFail].
	length := interpreterProxy stSizeOf: rcvr.
	rcvrPtr := self cCoerce: (interpreterProxy firstIndexableField: rcvr) to: #'float *'.
	0 to: length-1 do:[:i|
		rcvrPtr at: i put: (self cCoerce: (rcvrPtr at: i) to: #double) * value.
	].
	interpreterProxy pop: 1. "Leave rcvr on stack"