C translation
generateRounded: msgNode on: aStream indent: level
	"Generate the C code for rounded onto the given stream."

	aStream nextPutAll: 'round('.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $)