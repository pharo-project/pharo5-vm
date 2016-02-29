debug support
runLeakCheckerForFreeSpace: gcModes
	<inline: false>
	(gcModes anyMask: GCModeFreeSpace) ifTrue:
		[coInterpreter reverseDisplayFrom: 16 to: 19.
		 self clearLeakMapAndMapAccessibleFreeSpace.
		 self asserta: self checkHeapFreeSpaceIntegrity]