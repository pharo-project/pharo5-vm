C translation
generateGreaterThan: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream indent: level.
	aStream nextPutAll: ' > '.
	self emitCExpression: msgNode args first on: aStream indent: level