access primitives
primitiveHashArray

	| rcvr rcvrPtr length result |
	<export: true>
	<var: #rcvrPtr type: #'int *'>
	rcvr := interpreterProxy stackValue: 0.
	(interpreterProxy isWords: rcvr) ifFalse:
		[^interpreterProxy primitiveFail].
	length := interpreterProxy stSizeOf: rcvr.
	rcvrPtr := self cCoerce: (interpreterProxy firstIndexableField: rcvr) to: #'int *'.
	result := 0.
	0 to: length-1 do:[:i|
		result := result + (rcvrPtr at: i).
	].
	interpreterProxy pop: 1.
	^interpreterProxy pushInteger: (result bitAnd: 16r1FFFFFFF)