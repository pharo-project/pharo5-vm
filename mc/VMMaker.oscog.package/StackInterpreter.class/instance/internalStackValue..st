internal interpreter access
internalStackValue: offset
	"In the StackInterpreter stacks grow down."
	^stackPages longAtPointer: localSP + (offset * objectMemory bytesPerOop)