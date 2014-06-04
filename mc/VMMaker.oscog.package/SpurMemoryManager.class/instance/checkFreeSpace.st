debug support
checkFreeSpace
	self assert: self bitsSetInFreeSpaceMaskForAllFreeLists.
	self assert: totalFreeOldSpace = self totalFreeListBytes