C translation
generateCCoercion: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '(('.
	aStream nextPutAll: msgNode args last value.
	aStream nextPutAll: ') '.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPut: $)

