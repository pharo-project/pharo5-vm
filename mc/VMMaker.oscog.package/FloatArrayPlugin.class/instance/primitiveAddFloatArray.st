arithmetic primitives
primitiveAddFloatArray
	"Primitive. Add the receiver and the argument, both FloatArrays and store the result into the receiver."
	| rcvr arg rcvrPtr argPtr length |
	<export: true>
	<var: #rcvrPtr type:'float *'>
	<var: #argPtr type:'float *'>
	arg := interpreterProxy stackObjectValue: 0.
	rcvr := interpreterProxy stackObjectValue: 1.
	interpreterProxy failed ifTrue:[^nil].
	interpreterProxy success: (interpreterProxy isWords: arg).
	interpreterProxy success: (interpreterProxy isWords: rcvr).
	interpreterProxy failed ifTrue:[^nil].
	length := interpreterProxy stSizeOf: arg.
	interpreterProxy success: (length = (interpreterProxy stSizeOf: rcvr)).
	interpreterProxy failed ifTrue:[^nil].
	rcvrPtr := self cCoerce: (interpreterProxy firstIndexableField: rcvr) to: 'float *'.
	argPtr := self cCoerce: (interpreterProxy firstIndexableField: arg) to: 'float *'.
	0 to: length-1 do:[:i|
		rcvrPtr at: i put: (self cCoerce: (rcvrPtr at: i) to: 'double') + (self cCoerce: (argPtr at: i) to: 'double')].
	interpreterProxy pop: 1. "Leave rcvr on stack"