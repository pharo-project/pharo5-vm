C translation
generateInlineCppIfElseAsArgument: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."
	self generateInlineCppIfElse: msgNode asArgument: true on: aStream indent: level