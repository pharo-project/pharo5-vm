internal interpreter access
unPop: nItems
	"In the StackInterpreter stacks grow down."
	stackPointer := stackPointer - (nItems*objectMemory wordSize)