free space
validFreeTreeChunk: chunk
	<inline: false>
	(segmentManager segmentContainingObj: chunk) ifNil:
		[^false].
	^(self validFreeTreeChunk: chunk parent: (self fetchPointer: self freeChunkParentIndex ofFreeChunk: chunk)) isNil