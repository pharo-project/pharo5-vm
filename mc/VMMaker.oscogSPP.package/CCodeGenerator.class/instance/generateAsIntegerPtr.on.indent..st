C translation
generateAsIntegerPtr: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll:'((sqIntptr_t)'.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $)