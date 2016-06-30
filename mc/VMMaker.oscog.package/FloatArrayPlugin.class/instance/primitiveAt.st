access primitives
primitiveAt

	| index rcvr floatValue floatPtr |
	<export: true>
	<var: #floatValue type: #double>
	<var: #floatPtr type: #'float *'>
	index := interpreterProxy stackIntegerValue: 0.
	rcvr := interpreterProxy stackValue: 1.
	(interpreterProxy failed not
	 and: [(interpreterProxy isWords: rcvr)
	 and: [index > 0 and: [index <= (interpreterProxy slotSizeOf: rcvr)]]]) ifFalse:
		[^interpreterProxy primitiveFail].
	floatPtr := interpreterProxy firstIndexableField: rcvr.
	floatValue := (floatPtr at: index-1) asFloat.
	interpreterProxy pop: 2.
	interpreterProxy pushFloat: floatValue