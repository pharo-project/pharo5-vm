bootstrap image
isUnmappedObject: obj32
	"Answer if obj32 is an object that is not cloned by the bootstrap."
	^((heap32 classIndexOf: obj32)
			between: ClassLargeNegativeIntegerCompactIndex
			and: ClassFloatCompactIndex)
	  or: [obj32 = heap32 freeListsObject
	  or: [(heap32 isValidObjStackPage: obj32)]]