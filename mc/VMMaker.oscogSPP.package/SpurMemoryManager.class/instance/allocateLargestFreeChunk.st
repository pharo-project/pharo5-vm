free space
allocateLargestFreeChunk
	"Answer the largest free chunk in the free lists."
	<inline: false>
	| freeChunk next |
	"would like to use ifNotNil: but the ^next inside the ^blah ifNotNil: confused Slang"
	freeChunk := self findLargestFreeChunk.
	freeChunk ifNil: [^nil].
	"This will be the node, not a list element.  Answer a list element in preference."
	next := self fetchPointer: self freeChunkNextIndex ofFreeChunk: freeChunk.
	next ~= 0 ifTrue:
		[self storePointer: self freeChunkNextIndex
			ofFreeChunk: freeChunk
			withValue: (self fetchPointer: self freeChunkNextIndex ofFreeChunk: next).
		 ^next].
	self unlinkSolitaryFreeTreeNode: freeChunk.
	^freeChunk