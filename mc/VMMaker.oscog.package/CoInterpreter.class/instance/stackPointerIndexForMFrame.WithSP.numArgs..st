frame access
stackPointerIndexForMFrame: theFP WithSP: theSP numArgs: numArgs
	"Return the 1-based index rel to the given machine code frame"
	"In the StackInterpreter stacks grow down."
	^(((theFP + FoxMFReceiver) - theSP) >> objectMemory shiftForWord) + numArgs