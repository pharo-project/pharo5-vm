free space
addToFreeTree: freeChunk bytes: chunkBytes
	"Add freeChunk to the large free chunk tree.
	 For the benefit of sortedFreeObject:, answer the treeNode it is added
	 to, if it is added to the next list of a freeTreeNode, otherwise answer 0."
	| childBytes parent child |
	self assert: (self isFreeObject: freeChunk).
	self assert: chunkBytes = (self bytesInObject: freeChunk).
	self assert: chunkBytes >= (self numFreeLists * self allocationUnit).
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
		 self assert: ((self oop: freeChunk + chunkBytes isLessThan: child)
						or: [self oop: freeChunk isGreaterThanOrEqualTo: child + childBytes]).
		 childBytes = chunkBytes ifTrue: "size match; add to list at node."
			[self storePointer: self freeChunkNextIndex
					ofFreeChunk: freeChunk
						withValue: (self fetchPointer: self freeChunkNextIndex ofObject: child);
				storePointer: self freeChunkNextIndex
					ofFreeChunk: child
						withValue: freeChunk.
			 ^child].
		 "walk down the tree"
		 parent := child.
		 child := self fetchPointer: (childBytes > chunkBytes
										ifTrue: [self freeChunkSmallerIndex]
										ifFalse: [self freeChunkLargerIndex])
					ofFreeChunk: child].
	parent = 0 ifTrue:
		[self assert: (freeLists at: 0) = 0.
		 freeLists at: 0 put: freeChunk.
		 freeListsMask := freeListsMask bitOr: 1.
		 ^0].
	self assert: (freeListsMask anyMask: 1).
	"insert in tree"
	self storePointer: self freeChunkParentIndex
			ofFreeChunk: freeChunk
				withValue: parent.
	self storePointer: (childBytes > chunkBytes
									ifTrue: [self freeChunkSmallerIndex]
									ifFalse: [self freeChunkLargerIndex])
			ofFreeChunk: parent
				withValue: freeChunk.
	^0