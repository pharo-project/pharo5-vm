access primitives
primitiveEqual

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
	interpreterProxy pop: 2.
	length := interpreterProxy stSizeOf: arg.
	length = (interpreterProxy stSizeOf: rcvr) ifFalse:[^interpreterProxy pushBool: false].

	rcvrPtr := self cCoerce: (interpreterProxy firstIndexableField: rcvr) to: 'float *'.
	argPtr := self cCoerce: (interpreterProxy firstIndexableField: arg) to: 'float *'.
	0 to: length-1 do:[:i|
		(rcvrPtr at: i) = (argPtr at: i) ifFalse:[^interpreterProxy pushBool: false].
	].
	^interpreterProxy pushBool: true