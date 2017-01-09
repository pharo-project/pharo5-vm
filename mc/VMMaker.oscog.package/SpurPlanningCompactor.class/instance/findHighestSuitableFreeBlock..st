space management
findHighestSuitableFreeBlock: spaceEstimate
	"If a freeBlock of size at least spaceEstimate exists high enough in the heap, choose it.
	 Ignoring pinned objects for now, the total ammount of shrinkage is expected to be
	 at least totalFreeOldSpace (because of collected objects).  So any free chunk which is
	 at or above endOfMemory - totalFreeOldSpace should not be corrupted during compaction.
	 Let's play with this for a while and see how we get on."
	<inline: true>
	manager findLargestFreeChunk ifNotNil:
		[:largestFreeChunk|
		((manager bytesInObject: largestFreeChunk) >= spaceEstimate
		 and: [largestFreeChunk asUnsignedInteger > (manager endOfMemory - manager freeSize) asUnsignedInteger]) ifTrue:
			[^largestFreeChunk]].
	^nil