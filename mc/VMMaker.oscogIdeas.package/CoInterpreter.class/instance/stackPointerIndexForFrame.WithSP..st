frame access
stackPointerIndexForFrame: theFP WithSP: theSP
	"Return the 1-based index rel to the given frame"
	"In the StackInterpreter stacks grow down."
	^(self isMachineCodeFrame: theFP)
		ifTrue: [(((theFP + FoxMFReceiver) - theSP) >> objectMemory shiftForWord) + (self mframeNumArgs: theFP)]
		ifFalse: [(((theFP + FoxIFReceiver) - theSP) >> objectMemory shiftForWord) + (self iframeNumArgs: theFP)]