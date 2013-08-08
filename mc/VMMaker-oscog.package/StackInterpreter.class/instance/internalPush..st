internal interpreter access
internalPush: object
	"In the StackInterpreter stacks grow down."
	stackPages longAtPointer: (localSP := localSP - BytesPerOop) put: object