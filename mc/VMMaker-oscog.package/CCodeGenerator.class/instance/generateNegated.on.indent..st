C translation
generateNegated: msgNode on: aStream indent: level
	"Generate the C code for teh negated message onto the given stream."

	aStream nextPut: $-.
	self emitCExpression: msgNode receiver on: aStream