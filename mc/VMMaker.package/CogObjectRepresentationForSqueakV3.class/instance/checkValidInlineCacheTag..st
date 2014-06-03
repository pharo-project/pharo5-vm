garbage collection
checkValidInlineCacheTag: cacheTag
	^((cacheTag bitAnd: 1 << ShiftForWord - 1) = 0
		and: [cacheTag
				between: 1 << ShiftForWord
				and: (objectMemory compactClassIndexOfHeader: -1) << ShiftForWord])
	   or: [self checkValidObjectReference: cacheTag]