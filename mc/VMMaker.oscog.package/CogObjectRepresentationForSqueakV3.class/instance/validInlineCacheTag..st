garbage collection
validInlineCacheTag: cacheTag
	^cacheTag = ConstZero
	  or: [((cacheTag bitAnd: 1 << objectMemory shiftForWord - 1) = 0
		   and: [cacheTag
				between: 1 << objectMemory compactClassFieldLSB
				and: (objectMemory compactClassIndexOfHeader: -1) << objectMemory compactClassFieldLSB])
		 or: [self checkValidObjectReference: cacheTag]]