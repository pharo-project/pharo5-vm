compaction
reinitializeScan
	firstMobileObject := manager endOfMemory.
	firstFreeObject := self scanForFirstFreeAndFirstMobileObjectFrom: firstFreeObject.
	firstFreeObject ifNil:
		[self error: 'uncompactable heap; no unmarked objects found'].
	mobileStart := manager startOfObject: firstFreeObject