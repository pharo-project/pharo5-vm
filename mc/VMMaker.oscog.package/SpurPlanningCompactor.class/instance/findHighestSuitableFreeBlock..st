space management
findHighestSuitableFreeBlock: spaceEstimate
	"If a freeBlock of size at least spaceEstimate exists high enough in the heap, choose it."
	<inline: true>
	manager findLargestFreeChunk ifNotNil:
		[:largestFreeChunk|
		(manager bytesInObject: largestFreeChunk) >= spaceEstimate ifTrue:
			[^largestFreeChunk]].
	^nil