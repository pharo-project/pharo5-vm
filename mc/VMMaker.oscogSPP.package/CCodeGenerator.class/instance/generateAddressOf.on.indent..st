C translation
generateAddressOf: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPut: $(; nextPut: $&.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPut: $)