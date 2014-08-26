snapshot
initializeFreeSpacePostLoad: freeListObj
	"Reinitialize the free list info.  The freeLists object needs to be swizzled
	 because its neither a free, nor a pointer object.  Free objects have already
	 been swizzled in adjustAllOopsBy:"
	
	self assert: (self numSlotsOf: freeListObj) = self numFreeLists.
	self assert: (self formatOf: freeListObj) = self wordIndexableFormat.
	freeLists := self firstIndexableField: freeListObj.
	freeListsMask := 0.
	0 to: self numFreeLists - 1 do:
		[:i|
		(freeLists at: i) ~= 0 ifTrue:
			[freeListsMask := freeListsMask bitOr: (1 << i).
			 freeLists at: i put: (segmentManager swizzleObj: (freeLists at: i))]]