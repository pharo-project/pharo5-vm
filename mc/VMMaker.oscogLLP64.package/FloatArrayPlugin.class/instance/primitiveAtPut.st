access primitives
primitiveAtPut

	| value floatValue index rcvr floatPtr |
	<export: true>
	<var: #floatValue type: #double>
	<var: #floatPtr type: #'float *'>
	value := interpreterProxy stackValue: 0.
	(interpreterProxy isIntegerObject: value)
		ifTrue:[floatValue := (interpreterProxy integerValueOf: value) asFloat]
		ifFalse:[floatValue := interpreterProxy floatValueOf: value].
	index := interpreterProxy stackIntegerValue: 1.
	rcvr := interpreterProxy stackValue: 2.
	(interpreterProxy failed not
	 and: [(interpreterProxy isWords: rcvr)
	 and: [index > 0 and: [index <= (interpreterProxy slotSizeOf: rcvr)]]]) ifFalse:
		[^interpreterProxy primitiveFail].
	floatPtr := interpreterProxy firstIndexableField: rcvr.
	floatPtr at: index-1 put: (self cCoerce: floatValue to:#float).
	interpreterProxy pop: 3 thenPush: value