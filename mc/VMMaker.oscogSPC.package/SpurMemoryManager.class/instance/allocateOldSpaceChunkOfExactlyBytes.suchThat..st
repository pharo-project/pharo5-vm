free space
allocateOldSpaceChunkOfExactlyBytes: chunkBytes suchThat: acceptanceBlock
	"Answer a chunk of oldSpace from the free lists that satisfies acceptanceBlock,
	 if one of this size is available, otherwise answer nil.  N.B.  the chunk is simply a
	 pointer, it has no valid header.  The caller *must* fill in the header correctly."
	<var: #chunkBytes type: #usqInt>
	| index node next prev child childBytes |
	<inline: true> "must inline for acceptanceBlock"
	"for debugging:" "totalFreeOldSpace := self totalFreeListBytes"

	index := chunkBytes / self allocationUnit.
	index < self numFreeLists ifTrue:
		[(freeListsMask anyMask: 1 << index) ifTrue:
			[(node := freeLists at: index) = 0
				ifTrue: [freeListsMask := freeListsMask - (1 << index)]
				ifFalse:
					[prev := 0.
					 [node ~= 0] whileTrue:
						[self assert: node = (self startOfObject: node).
						 self assert: (self isValidFreeObject: node).
						 next := self fetchPointer: self freeChunkNextIndex ofFreeChunk: node.
						 (acceptanceBlock value: node) ifTrue:
							[prev = 0
								ifTrue: [freeLists at: index put: next]
								ifFalse: [self storePointer: self freeChunkNextIndex ofFreeChunk: prev withValue: next].
							 totalFreeOldSpace := totalFreeOldSpace - chunkBytes.
							 ^node].
						 prev := node.
						 node := next]]].
		 ^nil].

	"Large chunk.  Search the large chunk list.
	 Large chunk list organized as a tree, each node of which is a list of
	 chunks of the same size. Beneath the node are smaller and larger
	 blocks.  When the search ends parent should hold the first chunk of
	 the same size as chunkBytes, or 0 if none."
	node := 0.
	child := freeLists at: 0.
	[child ~= 0] whileTrue:
		[self assert: (self isValidFreeObject: child).
		 childBytes := self bytesInObject: child.
		 childBytes = chunkBytes
			ifTrue: "size match; try to remove from list at node first."
				[node := child.
				 [prev := node.
				  node := self fetchPointer: self freeChunkNextIndex ofFreeChunk: node.
				  node ~= 0] whileTrue:
					[(acceptanceBlock value: node) ifTrue:
						[self assert: (self isValidFreeObject: node).
						 self storePointer: self freeChunkNextIndex
							ofFreeChunk: prev
							withValue: (self fetchPointer: self freeChunkNextIndex ofFreeChunk: node).
						 totalFreeOldSpace := totalFreeOldSpace - chunkBytes.
						 ^self startOfObject: node]].
				 (acceptanceBlock value: child) ifFalse:
					[^nil]. "node was right size but unaceptable."
				 next := self fetchPointer: self freeChunkNextIndex ofFreeChunk: child.
				 next = 0
					ifTrue: "no list; remove the interior node"
						[self unlinkSolitaryFreeTreeNode: child]
					ifFalse: "list; replace node with it"
						[self inFreeTreeReplace: child with: next].
				 totalFreeOldSpace := totalFreeOldSpace - chunkBytes.
				 ^self startOfObject: child]
			ifFalse: "no size match; walk down the tree"
				[child := self fetchPointer: (childBytes < chunkBytes
												ifTrue: [self freeChunkLargerIndex]
												ifFalse: [self freeChunkSmallerIndex])
							ofFreeChunk: child]].
	^nil