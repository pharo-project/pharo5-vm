C translation
generateSignedIntFromLong: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '((int) '.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $)