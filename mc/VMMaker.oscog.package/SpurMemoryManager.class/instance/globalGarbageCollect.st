gc - global
globalGarbageCollect
	self cCode: [] inSmalltalk: [self halt: 'GC number ', statFullGCs printString].

	self assert: self validObjStacks.
	self assert: (self isEmptyObjStack: markStack).
	self assert: (self isEmptyObjStack: weaklingStack).

	self markObjects.
	self expungeDuplicateAndUnmarkedClasses: true.
	self nilUnmarkedWeaklingSlots.
	self freeUnmarkedObjectsAndSortAndCoalesceFreeSpaceForPigCompact.

	"Mid-way the leak check must be more lenient.  Unmarked classes will have been
	 expunged from the table, but unmarked instances will not yet have been reclaimed."
	self runLeakCheckerForFullGC: true
		excludeUnmarkedNewSpaceObjs: true
		classIndicesShouldBeValid: true.

	self compact.
	self setHeapSizeAtPreviousGC.

	self assert: self validObjStacks.
	self assert: (self isEmptyObjStack: markStack).
	self assert: (self isEmptyObjStack: weaklingStack).
	self assert: self allObjectsUnmarked.
	self runLeakCheckerForFullGC: true