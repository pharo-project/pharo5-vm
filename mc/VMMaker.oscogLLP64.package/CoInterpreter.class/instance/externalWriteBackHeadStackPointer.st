cog jit support
externalWriteBackHeadStackPointer
	self assert: (stackPointer < stackPage baseAddress
				and: [stackPointer > (stackPage realStackLimit - (LargeContextSlots * objectMemory bytesPerOop))]).
	stackPage headSP: stackPointer