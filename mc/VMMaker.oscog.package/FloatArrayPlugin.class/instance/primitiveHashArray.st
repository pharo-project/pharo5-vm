access primitives
primitiveHashArray

	| rcvr rcvrPtr length result |
	<export: true>
	<var: #rcvrPtr type:'int *'>
	rcvr := interpreterProxy stackObjectValue: 0.
	interpreterProxy failed ifTrue:[^nil].
	interpreterProxy success: (interpreterProxy isWords: rcvr).
	interpreterProxy failed ifTrue:[^nil].
	length := interpreterProxy stSizeOf: rcvr.
	rcvrPtr := self cCoerce: (interpreterProxy firstIndexableField: rcvr) to: 'int *'.
	result := 0.
	0 to: length-1 do:[:i|
		result := result + (rcvrPtr at: i).
	].
	interpreterProxy pop: 1.
	^interpreterProxy pushInteger: (result bitAnd: 16r1FFFFFFF)