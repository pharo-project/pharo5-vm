C translation
generateTruncateTo: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self assert: msgNode args first isConstant.
	self assert: msgNode args first value isInteger.
	self assert: msgNode args first value isPowerOfTwo.
	aStream nextPut: $(.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' & ~'; print: msgNode args first value - 1; nextPut: $)