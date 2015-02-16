C translation
generateLessThan: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	self emitSignedComparison: #< for: msgNode on: aStream indent: level