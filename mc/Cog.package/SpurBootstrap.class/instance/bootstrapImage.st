bootstrap image
bootstrapImage
	Transcript cr; nextPutAll: 'transforming image...'; flush.
	self cloneNilTrueAndFalse.
	self buildClassMap.
	self allocateClassTable.
	self cloneObjects.
	self fillInObjects.
	self fillInClassTable.
	newHeap initializePostBootstrap