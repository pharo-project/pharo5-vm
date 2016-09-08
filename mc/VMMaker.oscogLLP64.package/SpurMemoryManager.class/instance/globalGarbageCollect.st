gc - global
globalGarbageCollect
	<inline: true> "inline into fullGC"
	self assert: self validObjStacks.
	self assert: (self isEmptyObjStack: markStack).
	self assert: (self isEmptyObjStack: weaklingStack).

	self markObjects: true.
	self freeUnmarkedObjectsAndSortAndCoalesceFreeSpaceForPigCompact.

	"Mid-way the leak check must be more lenient.  Unmarked classes will have been
	 expunged from the table, but unmarked instances will not yet have been reclaimed."
	self runLeakCheckerFor: GCModeFull
		excludeUnmarkedNewSpaceObjs: true
		classIndicesShouldBeValid: true.

	self compact.
	self setHeapSizeAtPreviousGC.

	self assert: self validObjStacks.
	self assert: (self isEmptyObjStack: markStack).
	self assert: (self isEmptyObjStack: weaklingStack).
	self assert: self allObjectsUnmarked.
	self runLeakCheckerFor: GCModeFull