compaction
rebuildFreeListsForPigCompact
	"Rebuild the free lists from the doubly-linked free list."
	<inline: false>
	self assert: self checkTraversableSortedFreeList.
	manager totalFreeOldSpace: 0.
	self sortedFreeListDo:
		[:freeObj| | start bytes |
		 bytes := (manager bytesInObject: freeObj).
		 start := manager startOfObject: freeObj.
		 manager addFreeChunkWithBytes: bytes at: start].
	manager checkFreeSpace: GCModeFull