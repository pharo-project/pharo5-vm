compaction
sweepToCoallesceFreeSpaceForPigCompactFrom: lowestForwarder
	"Coallesce free chunks and forwarders, maintaining the doubly-linked free list."
	| lowest firstOfFreeRun startOfFreeRun endOfFreeRun prevPrevFree prevFree |
	<var: #lowestForwarder type: #usqInt>
	lowest := (lowestForwarder = 0 ifTrue: [manager endOfMemory] ifFalse: [lowestForwarder])
				min: (firstFreeChunk = 0 ifTrue: [manager endOfMemory] ifFalse: [firstFreeChunk]).
	firstOfFreeRun := prevPrevFree := prevFree := 0.
	manager allOldSpaceEntitiesFrom: lowest do:
		[:o|
		((manager isFreeObject: o) or: [manager isForwarded: o])
			ifTrue:
				[firstOfFreeRun = 0 ifTrue:
					[manager setObjectFree: o.
					 firstOfFreeRun := o.
					 startOfFreeRun := manager startOfObject: o].
				 endOfFreeRun := o]
			ifFalse:
				[firstOfFreeRun ~= 0 ifTrue:
					[| bytes |
					 bytes := (manager addressAfter: endOfFreeRun) - startOfFreeRun.
					 firstOfFreeRun := manager initFreeChunkWithBytes: bytes at: startOfFreeRun.
					 self inSortedFreeListLink: prevFree to: firstOfFreeRun given: prevPrevFree.
					 prevPrevFree := prevFree.
					 prevFree := firstOfFreeRun.
					 firstOfFreeRun := 0]]].
	firstOfFreeRun ~= 0 ifTrue:
		[| bytes |
		 bytes := (manager addressAfter: endOfFreeRun) - startOfFreeRun.
		 firstOfFreeRun := manager initFreeChunkWithBytes: bytes at: startOfFreeRun.
		 self inSortedFreeListLink: prevFree to: firstOfFreeRun given: prevPrevFree.
		 prevPrevFree := prevFree.
		 prevFree := firstOfFreeRun.
		 firstOfFreeRun := 0].
	prevFree ~= firstFreeChunk ifTrue:
		[manager storePointer: manager freeChunkNextIndex
			ofFreeChunk: prevFree
			withValue: prevPrevFree].
	lastFreeChunk := prevFree.
	self inSortedFreeListLink: lastFreeChunk to: 0 given: prevPrevFree.
	self assert: self checkTraversableSortedFreeList