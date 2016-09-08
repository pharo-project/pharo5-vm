C translation
generateAsAddress: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitCExpression: msgNode args first on: aStream