utilities
externalizeFPandSP
	"Copy the frame and stack pointers to global variables for use in primitives and other functions outside the interpret loop."
	self assert: (localSP < stackPage baseAddress
				and: [localSP > (stackPage realStackLimit - (LargeContextSlots * objectMemory bytesPerOop))]).
	stackPointer := localSP.
	framePointer := localFP