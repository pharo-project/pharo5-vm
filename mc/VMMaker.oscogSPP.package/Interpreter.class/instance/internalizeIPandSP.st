utilities
internalizeIPandSP
	"Copy the local instruction and stack pointer to local variables for rapid access within the interpret loop."

	localIP := self pointerForOop: instructionPointer.
	localSP := self pointerForOop: stackPointer.
	localHomeContext := theHomeContext.
