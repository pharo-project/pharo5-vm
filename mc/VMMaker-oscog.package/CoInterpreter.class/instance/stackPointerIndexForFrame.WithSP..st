frame access
stackPointerIndexForFrame: theFP WithSP: theSP
	"Return the 1-based index rel to the given frame"
	"In the StackInterpreter stacks grow down."
	^(self isMachineCodeFrame: theFP)
		ifTrue: [(((theFP + FoxMFReceiver) - theSP) >> ShiftForWord) + (self mframeNumArgs: theFP)]
		ifFalse: [(((theFP + FoxIFReceiver) - theSP) >> ShiftForWord) + (self iframeNumArgs: theFP)]