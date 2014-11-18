internal interpreter access
internalPopStack
	"In the StackInterpreter stacks grow down."
	| top |
	top := stackPages longAt: localSP.
	localSP := localSP + objectMemory bytesPerOop.
	^top