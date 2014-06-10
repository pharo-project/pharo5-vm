C translation
generateNot: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '!'.
	self emitCExpression: msgNode receiver on: aStream.