C translation
generateBitInvert32: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPut: $~.
	self emitCExpression: msgNode receiver on: aStream