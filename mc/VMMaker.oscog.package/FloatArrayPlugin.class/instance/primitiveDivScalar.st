arithmetic primitives
primitiveDivScalar
	"Primitive. Add the argument, a scalar value to the receiver, a FloatArray"
	| rcvr rcvrPtr value inverse length |
	<export: true>
	<var: #value type:'double '>
	<var: #inverse type:'double '>
	<var: #rcvrPtr type:'float *'>
	value := interpreterProxy stackFloatValue: 0.
	rcvr := interpreterProxy stackObjectValue: 1.
	interpreterProxy failed ifTrue:[^nil].
	value = 0.0 ifTrue:[^interpreterProxy primitiveFail].
	interpreterProxy success: (interpreterProxy isWords: rcvr).
	interpreterProxy failed ifTrue:[^nil].
	length := interpreterProxy stSizeOf: rcvr.
	rcvrPtr := self cCoerce: (interpreterProxy firstIndexableField: rcvr) to: 'float *'.
	inverse := 1.0 / value.
	0 to: length-1 do:[:i|
		rcvrPtr at: i put: (self cCoerce: (rcvrPtr at: i) to: 'double') * inverse.
	].
	interpreterProxy pop: 1. "Leave rcvr on stack"