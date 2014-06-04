C translation
generateIntegerObjectOf: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '(('.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPutAll: ' << 1) | 1)'.