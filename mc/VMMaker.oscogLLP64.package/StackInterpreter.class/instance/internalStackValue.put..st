internal interpreter access
internalStackValue: offset put: aValue
	"In the StackInterpreter stacks grow down."
	^stackPages longAtPointer: localSP + (offset * objectMemory bytesPerOop) put: aValue