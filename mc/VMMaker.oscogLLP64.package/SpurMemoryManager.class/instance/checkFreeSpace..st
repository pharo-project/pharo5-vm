debug support
checkFreeSpace: gcModes
	self assert: self bitsSetInFreeSpaceMaskForAllFreeLists.
	self assert: totalFreeOldSpace = self totalFreeListBytes.
	(gcModes > 0
	 and: [checkForLeaks allMask: (GCModeFreeSpace bitOr: gcModes)]) ifTrue:
		[self runLeakCheckerForFreeSpace: GCModeFreeSpace]