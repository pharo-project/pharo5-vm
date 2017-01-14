compaction
reinitializeScan
	"Search for firstFreeObject and firstMobileObject from lastMobileObject (which is
	 set to the hiddenRootsObject on the first pass)."
	firstMobileObject := manager endOfMemory.
	firstFreeObject := self scanForFirstFreeAndFirstMobileObjectFrom: lastMobileObject.
	firstFreeObject ifNil:
		[self error: 'uncompactable heap; no unmarked objects found'].
	mobileStart := manager startOfObject: firstFreeObject