garbage collection
fullGC
	"Do a mark/sweep garbage collection of the entire object memory. Free inaccessible objects but do not move them."

	<inline: false>
	DoAssertionChecks ifTrue:
		[self reverseDisplayFrom: 0 to: 7.
		 self clearLeakMapAndMapAccessibleObjects.
		 self checkHeapIntegrity].
	self preGCAction: GCModeFull.
	gcStartUsecs := self ioUTCMicrosecondsNow.
	statSweepCount := statMarkCount := statMkFwdCount := statCompMoveCount := 0.
	self clearRootsTable.
	self initWeakTableForIncrementalGC: false.
	youngStart := self startOfMemory.  "process all of memory"
	self markPhase.
	"Sweep phase returns the number of survivors.
	Use the up-to-date version instead the one from startup."
	totalObjectCount := self sweepPhase.
	self fullCompaction.
	allocationCount := 0.
	statFullGCs := statFullGCs + 1.
	statGCEndTime := self ioMicroMSecs.
	statFullGCUsecs := statFullGCUsecs + (self ioUTCMicrosecondsNow - gcStartUsecs).
	self capturePendingFinalizationSignals.

	youngStart := freeBlock.  "reset the young object boundary"
	self attemptToShrink.
	self postGCAction: GCModeFull.
	DoAssertionChecks ifTrue:
		[self clearLeakMapAndMapAccessibleObjects.
		 self checkHeapIntegrity.
		 self reverseDisplayFrom: 0 to: 7]