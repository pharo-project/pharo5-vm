access primitives
primitiveAt

	| index rcvr floatValue floatPtr |
	<export: true>
	<var: #floatValue type:'double '>
	<var: #floatPtr type:'float *'>
	index := interpreterProxy stackIntegerValue: 0.
	rcvr := interpreterProxy stackObjectValue: 1.
	interpreterProxy failed ifTrue:[^nil].
	interpreterProxy success: (interpreterProxy isWords: rcvr).
	interpreterProxy success: (index > 0 and:[index <= (interpreterProxy slotSizeOf: rcvr)]).
	interpreterProxy failed ifTrue:[^nil].
	floatPtr := interpreterProxy firstIndexableField: rcvr.
	floatValue := (floatPtr at: index-1) asFloat.
	interpreterProxy pop: 2.
	interpreterProxy pushFloat: floatValue.