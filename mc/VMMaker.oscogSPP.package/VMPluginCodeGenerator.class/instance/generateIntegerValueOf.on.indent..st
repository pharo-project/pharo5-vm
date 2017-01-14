C translation
generateIntegerValueOf: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPut: $(.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPutAll: ' >> NumSmallIntegerTagBits)'