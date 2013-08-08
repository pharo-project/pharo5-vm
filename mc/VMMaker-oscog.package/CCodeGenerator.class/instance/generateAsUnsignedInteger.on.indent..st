C translation
generateAsUnsignedInteger: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll:'((usqInt)'.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $)