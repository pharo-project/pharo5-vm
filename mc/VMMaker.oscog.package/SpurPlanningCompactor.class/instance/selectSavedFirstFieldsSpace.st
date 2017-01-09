space management
selectSavedFirstFieldsSpace
	"To compact the heap the algorithm must save the first field (used for the forwarding pointer)
	 of all moved objects. This is done in savedFirstFieldsSpace, a contiguous block of memory borrowed
	 for the duration of compaction. In a 32-bit system a typical upper bound on the space needed
	 is about 1/40 of the heap size.  The default new space size of 4Mb provides an eden of about
	 3.6 Mb, which would serve the needs of a 144 Mb heap.  The default segment increment of
	 16 Mb would serve the needs of a 640 Mb heap. Make an estimate of the size needed, and
	 either use eden, a large free chunk, or a newly-allocated segment, falling back on eden if
	 the alternatives can't be had."
	<inline: true>
	| spaceEstimate sizeOfEden |
	spaceEstimate := manager endOfMemory - manager firstObject // 40.
	sizeOfEden := scavenger eden limit - scavenger eden start.
	spaceEstimate > sizeOfEden ifTrue:
		[(self findHighestSuitableFreeBlock: spaceEstimate) ifNotNil:
			[:highestSuitableFreeBlock|
			 (spaceEstimate > (manager sizeOfFree: highestSuitableFreeBlock)
			  and: [self useSegmentForSavedFirstFieldsSpace: spaceEstimate]) ifTrue:
				[^self].
			 (manager sizeOfFree: highestSuitableFreeBlock) > sizeOfEden ifTrue:
				[self useFreeChunkForSavedFirstFieldsSpace: highestSuitableFreeBlock.
				 ^self]].
		 (self useSegmentForSavedFirstFieldsSpace: spaceEstimate) ifTrue:
			[^self]].
	self useEdenForSavedFirstFieldsSpace