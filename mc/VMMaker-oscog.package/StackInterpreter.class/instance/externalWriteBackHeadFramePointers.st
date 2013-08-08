stack pages
externalWriteBackHeadFramePointers
	<asmLabel: false>
	self assert:  (framePointer - stackPointer) < LargeContextSize.
	self assert: stackPage = stackPages mostRecentlyUsedPage.
	self setHeadFP: framePointer andSP: stackPointer inPage: stackPage.
	self assert: stackPages pageListIsWellFormed