C translation
generateAsUnsignedIntegerPtr: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll:'((usqIntptr_t)'.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $)