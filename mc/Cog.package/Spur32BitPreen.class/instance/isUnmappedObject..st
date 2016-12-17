bootstrap image
isUnmappedObject: obj32
	"Answer if obj32 is an object that is not cloned by the bootstrap."
	^obj32 = oldHeap freeListsObject
	  or: [(oldHeap isValidObjStackPage: obj32)]