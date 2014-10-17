garbage collection
checkValidInlineCacheTag: cacheTag
	^((cacheTag bitAnd: 1 << ShiftForWord - 1) = 0
		and: [cacheTag
				between: 1 << objectMemory compactClassFieldLSB
				and: (objectMemory compactClassIndexOfHeader: -1) << objectMemory compactClassFieldLSB])
	   or: [self checkValidObjectReference: cacheTag]