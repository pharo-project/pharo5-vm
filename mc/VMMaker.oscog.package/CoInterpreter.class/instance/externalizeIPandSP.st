utilities
externalizeIPandSP
	"Copy the local instruction, stack and frame pointers to global variables for use in primitives and other functions outside the interpret loop."

	self assert: localIP asUnsignedInteger ~= cogit ceReturnToInterpreterPC.
	instructionPointer := self oopForPointer: localIP.
	stackPointer := localSP.
	framePointer := localFP