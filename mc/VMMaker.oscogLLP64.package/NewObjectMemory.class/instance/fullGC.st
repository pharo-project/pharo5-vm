garbage collection
fullGC
	"Do a mark/sweep garbage collection of the entire object memory.
	 Free inaccessible objects but do not move them."

	<inline: false>
	fullGCLock > 0 ifTrue:
		[self warning: 'aborting fullGC because fullGCLock > 0'.
		 ^self].
	self runLeakCheckerFor: GCModeFull.
	self preGCAction: GCModeFull.
	needGCFlag := false.
	gcStartUsecs := self ioUTCMicrosecondsNow.
	statSweepCount := statMarkCount := statMkFwdCount := statCompMoveCount := 0.
	self clearRootsTable.
	self initWeakTableForIncrementalGC: false.
	youngStart := self startOfMemory.  "process all of memory"
	self markPhase: true.
	"Sweep phase returns the number of survivors.
	Use the up-to-date version instead the one from startup."
	totalObjectCount := self sweepPhaseForFullGC.
	self runLeakCheckerFor: GCModeFull.
	self fullCompaction.
	statFullGCs := statFullGCs + 1.
	statGCEndUsecs := self ioUTCMicrosecondsNow.
	statFullGCUsecs := statFullGCUsecs + (statGCEndUsecs - gcStartUsecs).
	self capturePendingFinalizationSignals.

	youngStart := freeStart.  "reset the young object boundary"
	self attemptToShrink.
	self postGCAction: GCModeFull.
	self runLeakCheckerFor: GCModeFull