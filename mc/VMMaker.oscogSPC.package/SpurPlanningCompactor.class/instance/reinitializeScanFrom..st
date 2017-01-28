compaction
reinitializeScanFrom: initialObject
	"Search for firstFreeObject and firstMobileObject from initialObject, which is the
	 hiddenRootsObject on the first pass, and the objectAfterLastMobileObject on
	 subsequent passes)."
	firstMobileObject := manager endOfMemory.
	firstFreeObject := self scanForFirstFreeAndFirstMobileObjectFrom: initialObject.
	firstFreeObject ifNotNil:
		[mobileStart := manager startOfObject: firstFreeObject]