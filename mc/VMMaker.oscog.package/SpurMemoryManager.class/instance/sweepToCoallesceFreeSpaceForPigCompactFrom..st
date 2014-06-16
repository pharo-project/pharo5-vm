compaction
sweepToCoallesceFreeSpaceForPigCompactFrom: lowestForwarder
	"Coallesce free chunks and forwarders, maintaining the doubly-linked free list."
	| lowest firstOfFreeRun startOfFreeRun endOfFreeRun prevPrevFree prevFree |
	<var: #lowestForwarder type: #usqInt>
	lowest := (lowestForwarder = 0 ifTrue: [endOfMemory] ifFalse: [lowestForwarder])
				min: (firstFreeChunk = 0 ifTrue: [endOfMemory] ifFalse: [firstFreeChunk]).
	firstOfFreeRun := prevPrevFree := prevFree := 0.
	self allOldSpaceEntitiesFrom: lowest do:
		[:o|
		((self isFreeObject: o) or: [self isForwarded: o])
			ifTrue:
				[firstOfFreeRun = 0 ifTrue:
					[self setObjectFree: o.
					 firstOfFreeRun := o.
					 startOfFreeRun := self startOfObject: o].
				 endOfFreeRun := o]
			ifFalse:
				[firstOfFreeRun ~= 0 ifTrue:
					[| bytes |
					 bytes := (self addressAfter: endOfFreeRun) - startOfFreeRun.
					 firstOfFreeRun := self initFreeChunkWithBytes: bytes at: startOfFreeRun.
					 self inSortedFreeListLink: prevFree to: firstOfFreeRun given: prevPrevFree.
					 prevPrevFree := prevFree.
					 prevFree := firstOfFreeRun.
					 firstOfFreeRun := 0]]].
	firstOfFreeRun ~= 0 ifTrue:
		[| bytes |
		 bytes := (self addressAfter: endOfFreeRun) - startOfFreeRun.
		 firstOfFreeRun := self initFreeChunkWithBytes: bytes at: startOfFreeRun.
		 self inSortedFreeListLink: prevFree to: firstOfFreeRun given: prevPrevFree.
		 prevPrevFree := prevFree.
		 prevFree := firstOfFreeRun.
		 firstOfFreeRun := 0].
	prevFree ~= firstFreeChunk ifTrue:
		[self storePointer: self freeChunkNextIndex
			ofFreeChunk: prevFree
			withValue: prevPrevFree].
	lastFreeChunk := prevFree.
	self inSortedFreeListLink: lastFreeChunk to: 0 given: prevPrevFree.
	self assert: self checkTraversableSortedFreeList