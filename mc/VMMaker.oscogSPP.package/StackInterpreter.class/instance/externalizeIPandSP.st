utilities
externalizeIPandSP
	"Copy the local instruction, stack and frame pointers to global variables for use in primitives and other functions outside the interpret loop."

	instructionPointer := self oopForPointer: localIP.
	stackPointer := localSP.
	framePointer := localFP