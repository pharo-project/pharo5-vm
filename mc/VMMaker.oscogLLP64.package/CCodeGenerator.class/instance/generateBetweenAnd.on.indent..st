C translation
generateBetweenAnd: msgNode on: aStream indent: level
	"Generate the C code for the between:and: message onto the given stream."

	aStream nextPutAll: '(('.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' >= '.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPutAll: ') && ('.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' <= '.
	self emitCExpression: msgNode args second on: aStream.
	aStream nextPutAll: '))'