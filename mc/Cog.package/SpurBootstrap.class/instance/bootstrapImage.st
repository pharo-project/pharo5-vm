bootstrap image
bootstrapImage
	oldHeap fullGC.
	self measureOldHeapPostGC.
	self initMaps.
	Transcript cr; nextPutAll: 'transforming image...'; flush.
	self cloneNilTrueAndFalse.
	self allocateFreeLists.
	self buildClassMap.
	self allocateClassTable.
	self cloneObjects.
	self fillInObjects.
	self fillInClassTable.
	newHeapSize := newHeap freeStart.
	newHeap initializePostBootstrap.
	self measureNewHeapPostInitPostBootstrap