primitives
primitiveSerialPortWrite: portNum from: array startingAt: startIndex count: count 
	| bytesWritten arrayPtr |
	self primitive: 'primitiveSerialPortWrite'
		parameters: #(SmallInteger ByteArray SmallInteger SmallInteger ).

	interpreterProxy success: (startIndex >= 1 and: [startIndex + count - 1 <= (interpreterProxy byteSizeOf: array cPtrAsOop)]).
	interpreterProxy failed
		ifFalse: [arrayPtr := array + startIndex - 1.
			bytesWritten := self
						serialPort: portNum
						Write: count
						From: arrayPtr].
	^ bytesWritten asSmallIntegerObj