stack access
stackValue: offset put: oop
	"In the StackInterpreter stacks grow down."
	^stackPages
		longAt: stackPointer + (offset*objectMemory wordSize)
		put: oop