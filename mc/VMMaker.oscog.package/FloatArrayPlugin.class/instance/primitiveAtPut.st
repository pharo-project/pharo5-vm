access primitives
primitiveAtPut

	| value floatValue index rcvr floatPtr |
	<export: true>
	<var: #floatValue type: 'double '>
	<var: #floatPtr type:'float *'>
	value := interpreterProxy stackValue: 0.
	(interpreterProxy isIntegerObject: value)
		ifTrue:[floatValue := (interpreterProxy integerValueOf: value) asFloat]
		ifFalse:[floatValue := interpreterProxy floatValueOf: value].
	index := interpreterProxy stackIntegerValue: 1.
	rcvr := interpreterProxy stackObjectValue: 2.
	interpreterProxy failed ifTrue:[^nil].
	interpreterProxy success: (interpreterProxy isWords: rcvr).
	interpreterProxy success: (index > 0 and:[index <= (interpreterProxy slotSizeOf: rcvr)]).
	interpreterProxy failed ifTrue:[^nil].
	floatPtr := interpreterProxy firstIndexableField: rcvr.
	floatPtr at: index-1 put: (self cCoerce: floatValue to:'float').
	interpreterProxy failed ifFalse: [interpreterProxy pop: 3 thenPush: value].