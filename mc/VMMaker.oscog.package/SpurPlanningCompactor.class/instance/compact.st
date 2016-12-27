compaction - api
compact
	"Sweep all of old space, sliding unpinned marked objects down over free and unmarked objects.
	 Let the segmentManager mark which segments contain pinned objects via notePinned:."
	| onePass |
	<inline: #never> "for profiling"
	self initializeScanCheckingForFullyCompactedHeap ifTrue:
		[^self unmarkObjectsInFullyCompactedHeap].
	self initializeCompaction.
	[onePass := self planCompactSavingForwarders.
	 self updatePointers.
	 self copyAndUnmark.
	 manager checkFreeSpace: GCModeFull.
	 onePass or: [biasForGC]] whileFalse:
		[self reinitializeScan;
			updateSavedFirstFieldsSpaceIfNecessary].
	self endCompaction