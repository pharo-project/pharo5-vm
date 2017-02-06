compaction - api
compact
	"Sweep all of old space, sliding unpinned marked objects down over free and unmarked objects.
	 Let the segmentManager mark which segments contain pinned objects via notePinned:."
	| finalPass firstPass |
	<inline: #never> "for profiling"
	self initializeScanCheckingForFullyCompactedHeap ifTrue:
		[^self unmarkObjectsInFullyCompactedHeap].
	self initializeCompaction.
	firstPass := true.
	[finalPass := self planCompactSavingForwarders.
	 self assert: (self validRelocationPlanInPass: finalPass) = 0.
	 self updatePointers.
	 self copyAndUnmark: firstPass.
	 "Would like to check here, but can't if multi-pass."
	 false ifTrue: [manager checkFreeSpace: GCModeFull].
	 "Currently we do only a single pass if a normal GC, assuming that a pass will
	  always compact plenty of space. But we should perhaps check this assumption
	  by looking at the large free tree and seeing that the ratio of the largest free
	  chunk to the total ammount of free space is high."
	 finalPass or: [biasForGC]] whileFalse:
		[firstPass := false.
		 self reinitializeScanFrom: firstFreeObject;
			updateSavedFirstFieldsSpaceIfNecessary].
	manager checkFreeSpace: GCModeFull.
	self endCompaction