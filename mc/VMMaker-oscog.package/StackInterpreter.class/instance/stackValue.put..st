internal interpreter access
stackValue: offset put: oop
	"In the StackInterpreter stacks grow down."
	^stackPages
		longAt: stackPointer + (offset*BytesPerWord)
		put: oop