compaction - api
compact
	"We'd like to use exact fit followed by best or first fit, but it doesn't work
	 well enough in practice.  So use pig compact.  Fill large free objects starting
	 from low memory with objects taken from the end of memory."
	<inline: #never> "for profiling"
	self freeUnmarkedObjectsAndSortAndCoalesceFreeSpaceForPigCompact.
	manager statCompactPassCount: manager statCompactPassCount + 1.
	self assert: (firstFreeChunk = 0 or: [manager isFreeObject: firstFreeChunk]).
	1 to: numCompactionPasses do:
		[:i|
		 self pigCompact.
		 self eliminateAndFreeForwardersForPigCompact].
	
	"The free lists are zeroed in freeUnmarkedObjectsAndSortAndCoalesceFreeSpaceForPigCompact.
	 They should still be zero here"
	self assert: manager freeListHeadsEmpty.
	self rebuildFreeListsForPigCompact