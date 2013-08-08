C translation
generateAsLong: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll:'((long)'.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $)