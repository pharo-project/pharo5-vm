primitives
primitiveUpdateGZipCrc32
	"Primitive. Update a 32bit CRC value."
	| collection stopIndex startIndex crc length bytePtr |
	<export: true>
	<var: #bytePtr type: #'unsigned char *'>
	interpreterProxy methodArgumentCount = 4
		ifFalse:[^interpreterProxy primitiveFail].
	collection := interpreterProxy stackObjectValue: 0.
	stopIndex := interpreterProxy stackIntegerValue: 1.
	startIndex := interpreterProxy stackIntegerValue: 2.
	crc := interpreterProxy positive32BitValueOf: (interpreterProxy stackValue: 3).
	interpreterProxy failed ifTrue: [^self].
	((interpreterProxy isBytes: collection) and:[stopIndex >= startIndex and:[startIndex > 0]])
		ifFalse:[^interpreterProxy primitiveFail].
	length := interpreterProxy byteSizeOf: collection.
	(stopIndex <= length) ifFalse:[^interpreterProxy primitiveFail].
	bytePtr := interpreterProxy firstIndexableField: collection.
	self cCode:'' inSmalltalk:[zipCrcTable := CArrayAccessor on: GZipWriteStream crcTable].
	startIndex := startIndex - 1.
	stopIndex := stopIndex - 1.
	startIndex to: stopIndex do:
		[:i|
		crc := (zipCrcTable at: ((crc bitXor: (bytePtr at: i)) bitAnd: 255)) bitXor: (crc >> 8)].
	interpreterProxy
		pop: 5 "args + rcvr"
		thenPush: (interpreterProxy positive32BitIntegerFor: crc)