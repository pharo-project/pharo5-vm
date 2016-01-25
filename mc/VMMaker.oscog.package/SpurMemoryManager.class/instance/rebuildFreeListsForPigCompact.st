compaction
rebuildFreeListsForPigCompact
	"Rebuild the free lists from the doubly-linked free list."
	<inline: false>
	self assert: self checkTraversableSortedFreeList.
	totalFreeOldSpace := 0.
	self sortedFreeListDo:
		[:freeObj| | start bytes |
		 bytes := (self bytesInObject: freeObj).
		 start := self startOfObject: freeObj.
		 self addFreeChunkWithBytes: bytes at: start].
	self checkFreeSpace: GCModeFull