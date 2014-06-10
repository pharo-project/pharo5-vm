C translation
generateNoMask: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPut: $(.
	self generateBitAnd: msgNode on: aStream indent: level.
	aStream nextPutAll: ') == 0'