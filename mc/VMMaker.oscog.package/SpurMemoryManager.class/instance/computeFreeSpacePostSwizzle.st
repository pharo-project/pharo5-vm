free space
computeFreeSpacePostSwizzle
	totalFreeOldSpace := self totalFreeListBytes.
	self checkFreeSpace: 0