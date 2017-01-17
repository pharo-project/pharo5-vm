C translation
generateAsVoidPointer: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '((void *)'.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $)