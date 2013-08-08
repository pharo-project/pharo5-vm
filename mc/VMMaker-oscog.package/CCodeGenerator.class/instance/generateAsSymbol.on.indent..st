C translation
generateAsSymbol: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream.
	 The receiver is expected to be a TConstantNode."

	aStream nextPutAll: (self cFunctionNameFor: msgNode receiver nameOrValue)