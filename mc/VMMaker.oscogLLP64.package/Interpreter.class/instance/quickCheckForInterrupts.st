process primitive support
quickCheckForInterrupts
	"Quick check for possible user or timer interrupts. Decrement a counter and only do a real check when counter reaches zero or when a low space or user interrupt is pending."
	"Note: Clients that trigger interrupts should set use forceInterruptCheck to set interruptCheckCounter to zero and get immediate results."
	"Note: Requires that instructionPointer and stackPointer be external."

	statQuickCheckForEvents := statQuickCheckForEvents + 1.
	((interruptCheckCounter := interruptCheckCounter - 1) <= 0)
		ifTrue: [self checkForInterrupts].
