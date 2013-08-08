arithmetic primitives
primitiveMulScalar
	"Primitive. Add the argument, a scalar value to the receiver, a FloatArray"
	| rcvr rcvrPtr value length |
	<export: true>
	<var: #value type:'double '>
	<var: #rcvrPtr type:'float *'>
	value := interpreterProxy stackFloatValue: 0.
	rcvr := interpreterProxy stackObjectValue: 1.
	interpreterProxy failed ifTrue:[^nil].
	interpreterProxy success: (interpreterProxy isWords: rcvr).
	interpreterProxy failed ifTrue:[^nil].
	length := interpreterProxy stSizeOf: rcvr.
	rcvrPtr := self cCoerce: (interpreterProxy firstIndexableField: rcvr) to: 'float *'.
	0 to: length-1 do:[:i|
		rcvrPtr at: i put: (self cCoerce: (rcvrPtr at: i) to: 'double') * value.
	].
	interpreterProxy pop: 1. "Leave rcvr on stack"