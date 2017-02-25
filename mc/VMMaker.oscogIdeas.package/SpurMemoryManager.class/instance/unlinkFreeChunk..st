free space
unlinkFreeChunk: freeChunk
	"Unlink a free object from the free lists. Do not alter totalFreeOldSpace. Used for coalescing."
	| chunkBytes index node next prev child childBytes |
	index := (chunkBytes := self bytesInObject: freeChunk) / self allocationUnit.
	(index < self numFreeLists and: [1 << index <= freeListsMask]) ifTrue:
		[self assert: ((freeListsMask anyMask: 1 << index) and: [(freeLists at: index) ~= 0]).
		 node := freeLists at: index.
		 prev := 0.
		 [node ~= 0] whileTrue:
			[self assert: node = (self startOfObject: node).
			 self assert: (self isValidFreeObject: node).
			 next := self fetchPointer: self freeChunkNextIndex ofFreeChunk: node.
			 node = freeChunk ifTrue:
				[prev = 0
					ifTrue: [freeLists at: index put: next]
					ifFalse: [self storePointer: self freeChunkNextIndex ofFreeChunk: prev withValue: next].
				 ^self].
			 prev := node.
			 node := next].
		 self error: 'freeChunk not found in free lists'].

	"Large chunk.  Search the large chunk tree."
	child := freeLists at: 0.
	node := 0.
	[child ~= 0] whileTrue:
		[self assert: (self isValidFreeObject: child).
		 childBytes := self bytesInObject: child.
		 childBytes = chunkBytes ifTrue: "size match; try to remove from list at node."
			[node := child.
			 [prev := node.
			  node := self fetchPointer: self freeChunkNextIndex ofFreeChunk: node.
			  node ~= 0] whileTrue:
				[node = freeChunk ifTrue:
					[self assert: (self isValidFreeObject: node).
					 self storePointer: self freeChunkNextIndex
						ofFreeChunk: prev
						withValue: (self fetchPointer: self freeChunkNextIndex ofFreeChunk: node).
					 ^self]].
			 child = freeChunk ifTrue:
				[next := self fetchPointer: self freeChunkNextIndex ofFreeChunk: child.
				 next = 0
					ifTrue: "no list; remove the interior node"
						[self unlinkSolitaryFreeTreeNode: child]
					ifFalse: "list; replace node with it"
						[self inFreeTreeReplace: child with: next].
				 ^self]].
		 child ~= 0 ifTrue:
			[childBytes < chunkBytes
				ifTrue: "node too small; walk down the larger size of the tree"
					[child := self fetchPointer: self freeChunkLargerIndex ofFreeChunk: child]
				ifFalse:
					[node := child.
					 child := self fetchPointer: self freeChunkSmallerIndex ofFreeChunk: node]]].

	self error: 'freeChunk not found in free tree'
	