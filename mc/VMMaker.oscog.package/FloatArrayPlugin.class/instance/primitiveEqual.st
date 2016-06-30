access primitives
primitiveEqual

	| rcvr arg rcvrPtr argPtr length |
	<export: true>
	<var: #rcvrPtr type: #'float *'>
	<var: #argPtr type: #'float *'>
	arg := interpreterProxy stackValue: 0.
	rcvr := interpreterProxy stackValue: 1.
	((interpreterProxy isWords: arg)
	 and: [(interpreterProxy isWords: rcvr)]) ifFalse:
		[^interpreterProxy primitiveFail].
	interpreterProxy pop: 2.
	(length := interpreterProxy stSizeOf: arg) = (interpreterProxy stSizeOf: rcvr) ifFalse:
		[^interpreterProxy pushBool: false].
	rcvrPtr := self cCoerce: (interpreterProxy firstIndexableField: rcvr) to: #'float *'.
	argPtr := self cCoerce: (interpreterProxy firstIndexableField: arg) to: #'float *'.
	0 to: length-1 do:[:i|
		(rcvrPtr at: i) = (argPtr at: i) ifFalse:[^interpreterProxy pushBool: false].
	].
	^interpreterProxy pushBool: true