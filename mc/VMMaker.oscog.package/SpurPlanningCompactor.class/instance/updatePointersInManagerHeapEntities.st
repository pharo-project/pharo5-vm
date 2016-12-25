compaction
updatePointersInManagerHeapEntities
	"The special non-pointer objects containing pointers, which are the objStacks and the rememberedSet,
	 must be updated manually sicme they will not be recognized as containing pointers in the normal sweep."
	manager relocateObjStacksForPlanningCompactor.
	(scavenger rememberedSetSize > 0
	 and: [self isMobile: firstFieldOfRememberedSet]) ifTrue:
		[firstFieldOfRememberedSet := manager fetchPointer: 0 ofObject: firstFieldOfRememberedSet].
	self relocateObjectsInHeapEntity: manager rememberedSetObj from: 1 to: scavenger rememberedSetSize - 1
	"Note that we /must not/ set the rememberedSetObj here since it is a slot in the hiddenRootsObj
	 and will be updated normally in updatePointersInInitialImmobileObjects.  So do not do
	(self isMobile: manager rememberedSetObj) ifTrue:
		[manager rememberedSetObj: (manager fetchPointer: 0 ofObject: manager rememberedSetObj)]"