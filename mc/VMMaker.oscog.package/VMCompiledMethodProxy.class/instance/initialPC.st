accessing
initialPC
	"Answer the program counter for the receiver's first bytecode."

	^(coInterpreter startPCOfMethod: oop) + 1