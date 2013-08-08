C translation
generateAsInteger: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll:'((sqInt)'.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $)