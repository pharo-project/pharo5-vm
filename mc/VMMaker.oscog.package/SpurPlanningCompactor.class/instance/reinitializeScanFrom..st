compaction
reinitializeScanFrom: initialObject
	"Search for firstFreeObject and firstMobileObject from initialObject, which is the
	 hiddenRootsObject on the first pass, and the objectAfterLastMobileObject on
	 subsequent passes)."
	firstMobileObject := manager endOfMemory.
	firstFreeObject := self scanForFirstFreeAndFirstMobileObjectFrom: initialObject.
	firstFreeObject ifNotNil:
		[mobileStart := manager startOfObject: firstFreeObject].
	objectAfterLastMobileObject ifNotNil:
		[manager allOldSpaceEntitiesFrom: firstFreeObject to: objectAfterLastMobileObject do:
			[:o|
			 ((manager isPinned: o)
			  or: [(manager isMarked: o) not
			  or: [objectAfterLastMobileObject = o]]) ifFalse:
				[manager setIsMarkedOf: o to: false]].
		 firstMobileObject := objectAfterLastMobileObject]