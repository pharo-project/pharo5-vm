C translation
generateAllMask: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '(('.
	self generateBitAnd: msgNode on: aStream indent: level.
	aStream nextPutAll: ') == '.
	self emitCExpression: msgNode args first on: aStream indent: level.
	aStream nextPut: $)