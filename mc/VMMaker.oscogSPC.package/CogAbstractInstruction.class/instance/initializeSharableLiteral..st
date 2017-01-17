initialization
initializeSharableLiteral: literal
	"For out-of-line literal support, initialize a sharable literal."
	opcode := Literal.
	annotation := nil. "separate := nil for Slang"
	address := nil.
	dependent := nil.
	operands
		at: 0 put: literal;
		at: 1 put: true;		"isSharable/isUnique not"
		at: 2 put: -1			"opcodeIndex"