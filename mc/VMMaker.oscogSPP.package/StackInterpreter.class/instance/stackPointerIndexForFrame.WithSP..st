frame access
stackPointerIndexForFrame: theFP WithSP: theSP
	"Return the 1-based index rel to the given frame"
	"In the StackInterpreter stacks grow down."
	^(((theFP + FoxReceiver) - theSP) >> objectMemory shiftForWord) + (self frameNumArgs: theFP)