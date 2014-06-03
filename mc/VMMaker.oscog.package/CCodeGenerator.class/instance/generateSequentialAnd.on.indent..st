C translation
generateSequentialAnd: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode receiver on: aStream indent: level.
	aStream crtab: level; nextPutAll: ' && ('.
	self emitCTestBlock: msgNode args first on: aStream indent: level.
	aStream nextPut: $)