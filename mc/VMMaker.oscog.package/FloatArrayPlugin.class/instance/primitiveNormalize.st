arithmetic primitives
primitiveNormalize

	"Primitive. Normalize the argument (A FloatArray) in place."

	| rcvr rcvrPtr length len |
	<export: true>
	<var: #rcvrPtr type:'float *'>
	<var: #len type:'double '>
	rcvr := interpreterProxy stackObjectValue: 0.
	interpreterProxy failed ifTrue:[^nil].
	interpreterProxy success: (interpreterProxy isWords: rcvr).
	interpreterProxy failed ifTrue:[^nil].
	length := interpreterProxy stSizeOf: rcvr.
	interpreterProxy success: true.
	rcvrPtr := self cCoerce: (interpreterProxy firstIndexableField: rcvr) to: 'float *'.
	len := 0.0.
	0 to: length-1 do:[:i|
		len := len + ((self cCoerce: (rcvrPtr at: i) to: 'double') * (self cCoerce: (rcvrPtr at: i) to: 'double')).
	].
	interpreterProxy success: (len > 0.0).
	interpreterProxy failed ifTrue:[^nil].

	len := self cCode: 'sqrt(len)' inSmalltalk: [len sqrt].
	0 to: length-1 do:[:i|
		rcvrPtr at: i put: ((self cCoerce: (rcvrPtr at: i) to: 'double') / len).
	].

	"Leave receiver on the stack."