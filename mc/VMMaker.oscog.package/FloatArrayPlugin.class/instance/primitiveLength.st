arithmetic primitives
primitiveLength

	"Primitive. Compute the length of the argument (sqrt of sum of component squares)."

	| rcvr rcvrPtr length result |
	<export: true>
	<var: #rcvrPtr type:'float *'>
	<var: #result type:'double '>
	rcvr := interpreterProxy stackObjectValue: 0.
	interpreterProxy failed ifTrue:[^nil].
	interpreterProxy success: (interpreterProxy isWords: rcvr).
	interpreterProxy failed ifTrue:[^nil].
	length := interpreterProxy stSizeOf: rcvr.
	interpreterProxy success: true.
	rcvrPtr := self cCoerce: (interpreterProxy firstIndexableField: rcvr) to: 'float *'.
	result := 0.0.
	0 to: length-1 do:[:i|
		result := result + ((self cCoerce: (rcvrPtr at: i) to: 'double') * (self cCoerce: (rcvrPtr at: i) to: 'double')).
	].
	result := self cCode: 'sqrt(result)' inSmalltalk: [result sqrt].
	interpreterProxy pop: 1 thenPush: (interpreterProxy floatObjectOf: result)