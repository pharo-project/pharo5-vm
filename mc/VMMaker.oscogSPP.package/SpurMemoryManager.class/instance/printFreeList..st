debug printing
printFreeList: chunkOrIndex
	<api>
	| freeChunk |
	(chunkOrIndex >= 0 and: [chunkOrIndex < self numFreeLists]) ifTrue:
		[^self printFreeList: (freeLists at: chunkOrIndex)].
	freeChunk := chunkOrIndex.
	[freeChunk ~= 0] whileTrue:
		[self printFreeChunk: freeChunk.
		 freeChunk := self fetchPointer: self freeChunkNextIndex ofFreeChunk: freeChunk]