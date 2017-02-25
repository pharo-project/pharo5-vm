garbage collection
incrementalGC
	"Do a mark/sweep garbage collection of just the young object 
	area of object memory (i.e., objects above youngStart), using 
	the root table to identify objects containing pointers to 
	young objects from the old object area."
	| survivorCount weDidGrow |
	<inline: false>
	rootTableOverflowed ifTrue:
		["root table overflow; cannot do an incremental GC because some roots are missing.
		 (this should be very rare)"
		 statRootTableOverflows := statRootTableOverflows + 1.
		 ^self fullGC].

	DoAssertionChecks ifTrue:
		[self reverseDisplayFrom: 8 to: 15.
		 self checkHeapIntegrity.
		 self checkInterpreterIntegrity.
		 self validate].

	self preGCAction: GCModeNewSpace.
	"incremental GC and compaction"

	gcStartUsecs := self ioUTCMicrosecondsNow.
	statSweepCount := statMarkCount := statMkFwdCount := statCompMoveCount := 0.
	self initWeakTableForIncrementalGC: true.
	self markPhase.
	self assert: weakRootCount <= WeakRootTableSize.
	1 to: weakRootCount do:[:i| self finalizeReference: (weakRoots at: i)].
	survivorCount := self sweepPhase.
	self incrementalCompaction.
	statAllocationCount := allocationCount.
	allocationCount := 0.
	statIncrGCs := statIncrGCs + 1.
	statGCEndTime := self ioMicroMSecs.
	statIGCDeltaUsecs := self ioUTCMicrosecondsNow - gcStartUsecs.
	statIncrGCUsecs := statIncrGCUsecs + statIGCDeltaUsecs.
	self capturePendingFinalizationSignals.

	self forceInterruptCheck. "Force an an interrupt check ASAP.We could choose to be clever here and only do this under certain time conditions. Keep it simple for now"
	
	statRootTableCount  := rootTableCount.
	statSurvivorCount := survivorCount.
	weDidGrow := false.
	(((survivorCount > tenuringThreshold)
			or: [rootTableCount >= RootTableRedZone])
			or: [forceTenureFlag == true])
		ifTrue: ["move up the young space boundary if 
			* there are too many survivors: 
			this limits the number of objects that must be 
			processed on future incremental GC's 
			* we're about to overflow the roots table 
			this limits the number of full GCs that may be caused 
			by root table overflows in the near future"
			forceTenureFlag := false.
			statTenures := statTenures + 1.
			self clearRootsTable.
			(((self sizeOfFree: freeBlock) < growHeadroom) and: 
				[gcBiasToGrow > 0]) 
				ifTrue: [self biasToGrow.
						weDidGrow := true].
			youngStart := freeBlock].
	self attemptToShrink.
	self postGCAction: GCModeNewSpace.
	DoAssertionChecks ifTrue:
		[self validate.
		 self checkHeapIntegrity.
		 self checkInterpreterIntegrity.
		 self reverseDisplayFrom: 8 to: 15].
	weDidGrow ifTrue: [self biasToGrowCheckGCLimit]