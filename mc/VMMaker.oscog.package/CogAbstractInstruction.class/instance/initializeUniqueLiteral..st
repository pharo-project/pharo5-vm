initialization
initializeUniqueLiteral: literal
	"For out-of-line literal support, initialize an unsharable literal."
	opcode := Literal.
	dependent := nil. "separate := nil for Slang"
	annotation := nil.
	operands
		at: 0 put: literal;
		at: 1 put: false;		"isSharable/isUnique not"
		at: 2 put: -1			"opcodeIndex"