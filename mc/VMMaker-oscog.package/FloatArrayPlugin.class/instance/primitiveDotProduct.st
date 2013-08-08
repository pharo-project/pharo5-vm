arithmetic primitives
primitiveDotProduct
	"Primitive. Compute the dot product of the receiver and the argument.
	The dot product is defined as the sum of the products of the individual elements."
	| rcvr arg rcvrPtr argPtr length result |
	<export: true>
	<var: #rcvrPtr type:'float *'>
	<var: #argPtr type:'float *'>
	<var: #result type:'double '>
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
	result := 0.0.
	0 to: length-1 do:[:i|
		result := result + ((self cCoerce: (rcvrPtr at: i) to: 'double') * (self cCoerce: (argPtr at: i) to: 'double')).
	].
	interpreterProxy pop: 2. "Pop args + rcvr"
	interpreterProxy pushFloat: result. "Return result"