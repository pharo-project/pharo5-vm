internal interpreter access
internalPop: nItems
	"In the StackInterpreter stacks grow down."
	localSP := localSP + (nItems * objectMemory bytesPerOop)