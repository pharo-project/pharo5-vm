C translation
generateAsFloat: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll:'((double) '.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' )'.