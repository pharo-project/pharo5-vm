stack pages
writeBackHeadFramePointers
	self assert: stackPage = stackPages mostRecentlyUsedPage.
	self setHeadFP: localFP andSP: localSP inPage: stackPage.
	self assert: stackPages pageListIsWellFormed