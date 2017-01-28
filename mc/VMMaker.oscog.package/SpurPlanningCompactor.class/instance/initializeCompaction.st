compaction
initializeCompaction
	manager checkFreeSpace: GCModeFull.
	self selectSavedFirstFieldsSpace.
	self unpinRememberedSet.
	manager
		resetFreeListHeads;
		totalFreeOldSpace: 0;
		beginSlidingCompaction.
	savedFirstFieldsSpace top: savedFirstFieldsSpace start - manager bytesPerOop