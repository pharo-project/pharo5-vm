symbolic printing
key
	"For InstructionPrinter>>pushLiteralVariable:"
	^coInterpreter stringOf: (objectMemory fetchPointer: 0 ofObject: oop)