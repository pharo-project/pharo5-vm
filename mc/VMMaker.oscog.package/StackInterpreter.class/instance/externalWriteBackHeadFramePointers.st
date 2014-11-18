stack pages
externalWriteBackHeadFramePointers
	self assert:  (framePointer - stackPointer) < (LargeContextSlots * objectMemory bytesPerOop).
	self assert: stackPage = stackPages mostRecentlyUsedPage.
	self setHeadFP: framePointer andSP: stackPointer inPage: stackPage.
	self assert: stackPages pageListIsWellFormed