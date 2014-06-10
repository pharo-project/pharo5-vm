primitives
primitiveMIDIWrite: portNum from: array at: time

	| arrayLength bytesWritten |
	self primitive: 'primitiveMIDIWrite'
		parameters: #(SmallInteger ByteArray SmallInteger).
	arrayLength := interpreterProxy byteSizeOf: array cPtrAsOop.
	bytesWritten := self sqMIDIPort: portNum
			Write: arrayLength
			From: array asInteger
			At: time.
	^bytesWritten asSmallIntegerObj