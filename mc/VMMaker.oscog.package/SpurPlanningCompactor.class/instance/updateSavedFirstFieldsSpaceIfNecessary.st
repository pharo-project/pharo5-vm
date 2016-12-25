space management
updateSavedFirstFieldsSpaceIfNecessary
	"If savedFirstFieldsSpace is a free chunk then it may need to be repositioned if there is more than one pass."

	((manager isInOldSpace: savedFirstFieldsSpace start)
	 and: [savedFirstFieldsSpaceWasAllocated not]) ifTrue:
		[self useFreeChunkForSavedFirstFieldsSpace: manager findLargestFreeChunk].

	savedFirstFieldsSpace top: savedFirstFieldsSpace start - manager bytesPerOop.
	manager resetFreeListHeads