C translation
generateAtPut: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $[.
	msgNode args first emitCCodeAsExpressionOn: aStream level: level + 1 generator: self.
	aStream nextPutAll: '] = '.
	self emitCExpression: msgNode args last on: aStream