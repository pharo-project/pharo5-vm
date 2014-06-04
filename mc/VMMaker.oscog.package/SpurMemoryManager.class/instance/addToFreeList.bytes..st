free space
addToFreeList: freeChunk bytes: chunkBytes
	"Add freeChunk to the relevant freeList.
	 For the benefit of sortedFreeObject:, if freeChunk is large, answer the treeNode it
	 is added to, if it is added to the next list of a freeTreeNode, otherwise answer 0."
	| index |
	"coInterpreter transcript ensureCr. coInterpreter print: 'freeing '. self printFreeChunk: freeChunk."
	self assert: (self isFreeObject: freeChunk).
	self assert: chunkBytes = (self bytesInObject: freeChunk).
	index := chunkBytes / self allocationUnit.
	index < self numFreeLists ifTrue:
		[self storePointer: self freeChunkNextIndex ofFreeChunk: freeChunk withValue: (freeLists at: index).
		 freeLists at: index put: freeChunk.
		 freeListsMask := freeListsMask bitOr: 1 << index.
		 ^0].

	^self addToFreeTree: freeChunk bytes: chunkBytes