compaction - api
compact
	"Sweep all of old space, sliding unpinned marked objects down over free and unmarked objects.
	 Let the segmentManager mark which segments contain pinned objects via notePinned:."
	| onePass firstPass |
	<inline: #never> "for profiling"
	self initializeScanCheckingForFullyCompactedHeap ifTrue:
		[^self unmarkObjectsInFullyCompactedHeap].
	self initializeCompaction.
	firstPass := true.
	[onePass := self planCompactSavingForwarders.
	 self assert: (self validRelocationPlanInPass: onePass) = 0.
	 objectAfterLastMobileObject := manager oldSpaceObjectAfter: lastMobileObject.
	 self updatePointers.
	 self copyAndUnmark: firstPass.
	 "Would like to check here, but can't if multi-pass."
	 false ifTrue: [manager checkFreeSpace: GCModeFull].
	 onePass or: [biasForGC]] whileFalse:
		[firstPass := false.
		 self reinitializeScanFrom: objectAfterLastMobileObject;
			updateSavedFirstFieldsSpaceIfNecessary].
	manager checkFreeSpace: GCModeFull.
	self endCompaction