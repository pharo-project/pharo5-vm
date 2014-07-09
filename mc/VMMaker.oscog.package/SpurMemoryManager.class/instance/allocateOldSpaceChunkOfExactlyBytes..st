free space
allocateOldSpaceChunkOfExactlyBytes: chunkBytes
	"Answer a chunk of oldSpace from the free lists, if one of this size
	 is available, otherwise answer nil.  N.B.  the chunk is simply a pointer,
	 it has no valid header.  The caller *must* fill in the header correctly."
	<var: #chunkBytes type: #usqInt>
	| index node child |
	"for debugging:" "totalFreeOldSpace := self totalFreeListBytes"

	index := chunkBytes / self allocationUnit.
	index < self numFreeLists ifTrue:
		[(freeListsMask anyMask: 1 << index) ifTrue:
			[(node := freeLists at: index) ~= 0 ifTrue:
				[self assert: node = (self startOfObject: node).
				 self assert: (self isValidFreeObject: node).
				 totalFreeOldSpace := totalFreeOldSpace - chunkBytes.
				 ^self unlinkFreeChunk: node atIndex: index].
			 freeListsMask := freeListsMask - (1 << index)].
		 ^nil].

	"Large chunk.  Search the large chunk list.
	 Large chunk list organized as a tree, each node of which is a list of
	 chunks of the same size. Beneath the node are smaller and larger
	 blocks.  When the search ends parent should hold the first chunk of
	 the same size as chunkBytes, or 0 if none."
	child := freeLists at: 0.
	[child ~= 0] whileTrue:
		[| childBytes |
		 self assert: (self isValidFreeObject: child).
		 childBytes := self bytesInObject: child.
		 childBytes = chunkBytes
			ifTrue: "size match; try to remove from list at node."
				[node := self fetchPointer: self freeChunkNextIndex
								ofFreeChunk: child.
				 node ~= 0 ifTrue:
					[self assert: (self isValidFreeObject: node).
					 self storePointer: self freeChunkNextIndex
						ofFreeChunk: child
						withValue: (self fetchPointer: self freeChunkNextIndex
										ofFreeChunk: node).
					 totalFreeOldSpace := totalFreeOldSpace - chunkBytes.
					 ^self startOfObject: node].
				 "nothing acceptable on node's list; answer the node."
				 self unlinkSolitaryFreeTreeNode: child.
				 totalFreeOldSpace := totalFreeOldSpace - chunkBytes.
				 ^self startOfObject: child]
			ifFalse:
				[child := self fetchPointer: (childBytes < chunkBytes
												ifTrue: [self freeChunkLargerIndex]
												ifFalse: [self freeChunkSmallerIndex])
							ofFreeChunk: child]].
	^nil