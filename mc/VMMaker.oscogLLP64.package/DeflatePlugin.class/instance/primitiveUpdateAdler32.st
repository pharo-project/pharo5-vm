primitives
primitiveUpdateAdler32
	"Primitive. Update a 32bit CRC value."
	| collection stopIndex startIndex length bytePtr s1 adler32 s2 b |
	<export: true>
	<var: #adler32 type:'unsigned int '>
	<var: #bytePtr type:'unsigned char *'>
	interpreterProxy methodArgumentCount = 4
		ifFalse:[^interpreterProxy primitiveFail].
	collection := interpreterProxy stackObjectValue: 0.
	stopIndex := interpreterProxy stackIntegerValue: 1.
	startIndex := interpreterProxy stackIntegerValue: 2.
	adler32 := interpreterProxy positive32BitValueOf: (interpreterProxy stackValue: 3).
	interpreterProxy failed ifTrue:[^0].
	((interpreterProxy isBytes: collection) and:[stopIndex >= startIndex and:[startIndex > 0]])
		ifFalse:[^interpreterProxy primitiveFail].
	length := interpreterProxy byteSizeOf: collection.
	(stopIndex <= length) ifFalse:[^interpreterProxy primitiveFail].
	bytePtr := interpreterProxy firstIndexableField: collection.
	startIndex := startIndex - 1.
	stopIndex := stopIndex - 1.
	s1 := adler32 bitAnd: 16rFFFF.
	s2 := (adler32 >> 16) bitAnd: 16rFFFF.
	startIndex to: stopIndex do:[:i|
		b := bytePtr at: i.
		s1 := (s1 + b) \\ 65521.
		s2 := (s2 + s1) \\ 65521.
	].
	adler32 := (s2 bitShift: 16) + s1.
	interpreterProxy
		pop: 5 "args + rcvr"
		thenPush: (interpreterProxy positive32BitIntegerFor: adler32)