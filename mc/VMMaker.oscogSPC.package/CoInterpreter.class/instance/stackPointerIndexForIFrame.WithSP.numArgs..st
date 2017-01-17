frame access
stackPointerIndexForIFrame: theFP WithSP: theSP numArgs: numArgs
	"Return the 1-based index rel to the given frame"
	"In the StackInterpreter stacks grow down."
	^(((theFP + FoxIFReceiver) - theSP) >> objectMemory shiftForWord) + numArgs