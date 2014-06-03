C translation
generateIsNil: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' == '.
	aStream nextPutAll: (self cLiteralFor: nil).