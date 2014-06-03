C translation
generateBitClear: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream next: 2 put: $(.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' | '.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPutAll: ') - '.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPut: $)