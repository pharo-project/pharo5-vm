cog jit support
externalWriteBackHeadStackPointer
	self assert: (stackPointer < stackPage baseAddress
				and: [stackPointer > (stackPage realStackLimit - LargeContextSize)]).
	stackPage headSP: stackPointer