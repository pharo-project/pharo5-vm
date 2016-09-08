C translation
generateSignedIntFromLong64: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '((sqLong) '.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $)