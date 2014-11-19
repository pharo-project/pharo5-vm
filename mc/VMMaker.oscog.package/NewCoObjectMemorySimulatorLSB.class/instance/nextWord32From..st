initialization
nextWord32From: aStream
	"Read a 32-bit quantity from the given (binary) stream."

	^aStream nextLittleEndianNumber: 4