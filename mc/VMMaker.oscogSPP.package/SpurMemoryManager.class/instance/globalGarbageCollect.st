gc - global
globalGarbageCollect
	<inline: true> "inline into fullGC"
	self assert: self validObjStacks.
	self assert: (self isEmptyObjStack: markStack).
	self assert: (self isEmptyObjStack: weaklingStack).

	"Mark objects /before/ scavenging, to empty the rememberedTable of unmarked roots."
	self markObjects: true.

	scavenger forgetUnmarkedRememberedObjects.
	self doScavenge: MarkOnTenure.

	"Mid-way the leak check must be more lenient.  Unmarked classes will have been
	 expunged from the table, but unmarked instances will not yet have been reclaimed."
	self runLeakCheckerFor: GCModeFull
		excludeUnmarkedObjs: true
		classIndicesShouldBeValid: true.

	segmentManager prepareForGlobalSweep. "for notePinned:"
	compactor compact.
	self attemptToShrink.
	self setHeapSizeAtPreviousGC.

	self assert: self validObjStacks.
	self assert: (self isEmptyObjStack: markStack).
	self assert: (self isEmptyObjStack: weaklingStack).
	self assert: self allObjectsUnmarked.
	self runLeakCheckerFor: GCModeFull