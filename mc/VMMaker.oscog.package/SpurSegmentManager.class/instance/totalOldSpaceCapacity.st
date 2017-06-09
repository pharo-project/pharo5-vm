accessing
totalOldSpaceCapacity
	^totalHeapSizeIncludingBridges - (numSegments * manager bridgeSize)