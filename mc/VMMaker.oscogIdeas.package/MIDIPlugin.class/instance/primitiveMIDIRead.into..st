primitives
primitiveMIDIRead: portNum into: array

	| arrayLength bytesRead |
	self primitive: 'primitiveMIDIRead'
		parameters: #(SmallInteger ByteArray).
	arrayLength := interpreterProxy byteSizeOf: array cPtrAsOop.
	bytesRead := self sqMIDIPort: portNum
			Read: arrayLength
			Into: array.
	^bytesRead asSmallIntegerObj