converting
asByteArray
	^ ByteArray
		streamContents: [:strm | self writeTo: strm littleEndian: Smalltalk isLittleEndian]