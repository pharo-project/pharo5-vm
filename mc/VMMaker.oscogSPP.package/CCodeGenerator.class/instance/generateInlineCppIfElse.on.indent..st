C translation
generateInlineCppIfElse: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."
	self generateInlineCppIfElse: msgNode asArgument: false on: aStream indent: level