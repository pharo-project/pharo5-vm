utilities
internalizeIPandSP
	"Copy the instruction, stack and frame pointers to local variables for rapid access within the interpret loop."

	self assert: instructionPointer ~= cogit ceReturnToInterpreterPC.
	localIP := self pointerForOop: instructionPointer.
	localSP := self pointerForOop: stackPointer.
	localFP := self pointerForOop: framePointer.
	LowcodeVM ifTrue: [ nativeSP := 0. ]