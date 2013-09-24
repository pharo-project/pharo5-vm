free space
addToFreeList: freeChunk
	| chunkBytes childBytes parent child index |
	"coInterpreter transcript ensureCr. coInterpreter print: 'freeing '. self printFreeChunk: freeChunk."
	chunkBytes := self bytesInObject: freeChunk.
	index := chunkBytes / self allocationUnit.
	index < NumFreeLists ifTrue:
		[self storePointer: self freeChunkNextIndex ofFreeChunk: freeChunk withValue: (freeLists at: index).
		 freeLists at: index put: freeChunk.
		 freeListsMask := freeListsMask bitOr: 1 << index.
		 ^self].
	freeListsMask := freeListsMask bitOr: 1.
	self
		storePointer: self freeChunkNextIndex ofFreeChunk: freeChunk withValue: 0;
		storePointer: self freeChunkParentIndex ofFreeChunk: freeChunk withValue: 0;
		storePointer: self freeChunkSmallerIndex ofFreeChunk: freeChunk withValue: 0;
		storePointer: self freeChunkLargerIndex ofFreeChunk: freeChunk withValue: 0.
	"Large chunk list organized as a tree, each node of which is a list of chunks of the same size.
	 Beneath the node are smaller and larger blocks."
	parent := 0.
	child := freeLists at: 0.
	[child ~= 0] whileTrue:
		[childBytes := self bytesInObject: child.
		 childBytes = chunkBytes ifTrue: "size match; add to list at node."
			[self storePointer: self freeChunkNextIndex
					ofFreeChunk: freeChunk
						withValue: (self fetchPointer: self freeChunkNextIndex ofObject: child);
				storePointer: self freeChunkNextIndex
					ofFreeChunk: child
						withValue: freeChunk.
			 ^self].
		 "walk down the tree"
		 parent := child.
		 child := self fetchPointer: (childBytes > chunkBytes
										ifTrue: [self freeChunkSmallerIndex]
										ifFalse: [self freeChunkLargerIndex])
					ofObject: child].
	parent = 0 ifTrue:
		[self assert: (freeLists at: 0) = 0.
		 freeLists at: 0 put: freeChunk.
		 ^self].
	"insert in tree"
	self storePointer: self freeChunkParentIndex
			ofFreeChunk: freeChunk
				withValue: parent.
	 self storePointer: (childBytes > chunkBytes
									ifTrue: [self freeChunkSmallerIndex]
									ifFalse: [self freeChunkLargerIndex])
			ofFreeChunk: parent
				withValue: freeChunk