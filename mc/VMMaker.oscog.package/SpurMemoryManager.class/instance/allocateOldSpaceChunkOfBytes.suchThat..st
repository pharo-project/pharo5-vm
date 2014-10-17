free space
allocateOldSpaceChunkOfBytes: chunkBytes suchThat: acceptanceBlock
	"Answer a chunk of oldSpace from the free lists that satisfies acceptanceBlock,
	 if available, otherwise answer nil.  Break up a larger chunk if one of the exact
	 size cannot be found.  N.B.  the chunk is simply a pointer, it has no valid header.
	 The caller *must* fill in the header correctly."
	<var: #chunkBytes type: #usqInt>
	| initialIndex node next prev index child childBytes acceptedChunk acceptedNode |
	<inline: true> "must inline for acceptanceBlock"
	"for debugging:" "totalFreeOldSpace := self totalFreeListBytes"
	totalFreeOldSpace := totalFreeOldSpace - chunkBytes. "be optimistic (& don't wait for the write)"
	initialIndex := chunkBytes / self allocationUnit.
	(initialIndex < self numFreeLists and: [1 << initialIndex <= freeListsMask]) ifTrue:
		[(freeListsMask anyMask: 1 << initialIndex) ifTrue:
			[(node := freeLists at: initialIndex) = 0
				ifTrue: [freeListsMask := freeListsMask - (1 << initialIndex)]
				ifFalse:
					[prev := 0.
					 [node ~= 0] whileTrue:
						[self assert: node = (self startOfObject: node).
						 self assert: (self isValidFreeObject: node).
						 next := self fetchPointer: self freeChunkNextIndex ofFreeChunk: node.
						 (acceptanceBlock value: node) ifTrue:
							[prev = 0
								ifTrue: [freeLists at: initialIndex put: next]
								ifFalse: [self storePointer: self freeChunkNextIndex ofFreeChunk: prev withValue: next].
							 ^node].
						 prev := node.
						 node := next]]].
		 "first search for free chunks of a multiple of chunkBytes in size"
		 index := initialIndex.
		 [(index := index + initialIndex) < self numFreeLists
		  and: [1 << index <= freeListsMask]] whileTrue:
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
								 self freeChunkWithBytes: index * self allocationUnit - chunkBytes
									at: (self startOfObject: node) + chunkBytes.
								 ^node].
							 prev := node.
							 node := next]]]].
		 "now get desperate and use the first that'll fit.
		  Note that because the minimum free size is 16 bytes (2 * allocationUnit), to
		  leave room for the forwarding pointer/next free link, we can only break chunks
		  that are at least 16 bytes larger, hence start at initialIndex + 2."
		 index := initialIndex + 1.
		 [(index := index + 1) < self numFreeLists
		  and: [1 << index <= freeListsMask]] whileTrue:
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
								 self freeChunkWithBytes: index * self allocationUnit - chunkBytes
									at: (self startOfObject: node) + chunkBytes.
								 ^node].
							 prev := node.
							 node := next]]]]].

	"Large chunk, or no space on small free lists.  Search the large chunk list.
	 Large chunk list organized as a tree, each node of which is a list of chunks
	 of the same size. Beneath the node are smaller and larger blocks.
	 When the search ends parent should hold the smallest chunk at least as
	 large as chunkBytes, or 0 if none.  acceptedChunk and acceptedNode save
	 us from having to back-up when the acceptanceBlock filters-out all nodes
	 of the right size, but there are nodes of the wrong size it does accept."
	child := freeLists at: 0.
	node := acceptedChunk := acceptedNode := 0.
	[child ~= 0] whileTrue:
		[self assert: (self isValidFreeObject: child).
		 childBytes := self bytesInObject: child.
		 childBytes = chunkBytes ifTrue: "size match; try to remove from list at node."
			[node := child.
			 [prev := node.
			  node := self fetchPointer: self freeChunkNextIndex ofFreeChunk: node.
			  node ~= 0] whileTrue:
				[(acceptanceBlock value: node) ifTrue:
					[self assert: (self isValidFreeObject: node).
					 self storePointer: self freeChunkNextIndex
						ofFreeChunk: prev
						withValue: (self fetchPointer: self freeChunkNextIndex ofFreeChunk: node).
					 ^self startOfObject: node]].
			 (acceptanceBlock value: child) ifTrue:
				[next := self fetchPointer: self freeChunkNextIndex ofFreeChunk: child.
				 next = 0
					ifTrue: "no list; remove the interior node"
						[self unlinkSolitaryFreeTreeNode: child]
					ifFalse: "list; replace node with it"
						[self inFreeTreeReplace: child with: next].
				 ^self startOfObject: child]].
		 child ~= 0 ifTrue:
			["Note that because the minimum free size is 16 bytes (2 * allocationUnit), to
			  leave room for the forwarding pointer/next free link, we can only break chunks
			  that are at least 16 bytes larger, hence reject chunks < 2 * allocationUnit larger."
			childBytes <= (chunkBytes + self allocationUnit)
				ifTrue: "node too small; walk down the larger size of the tree"
					[child := self fetchPointer: self freeChunkLargerIndex ofFreeChunk: child]
				ifFalse:
					[self flag: 'we can do better here; preferentially choosing the lowest node. That would be a form of best-fit since we are trying to compact down'.
					 node := child.
					 child := self fetchPointer: self freeChunkSmallerIndex ofFreeChunk: node.
					 acceptedNode = 0 ifTrue:
						[acceptedChunk := node.
						 "first search the list."
						 [acceptedChunk := self fetchPointer: self freeChunkNextIndex
													ofFreeChunk: acceptedChunk.
						  (acceptedChunk ~= 0 and: [acceptanceBlock value: acceptedChunk]) ifTrue:
							[acceptedNode := node].
						  acceptedChunk ~= 0 and: [acceptedNode = 0]] whileTrue.
						 "nothing on the list; will the node do?  This prefers
						  acceptable nodes higher up the tree over acceptable
						  list elements further down, but we haven't got all day..."
						 (acceptedNode = 0
						  and: [acceptanceBlock value: node]) ifTrue:
							[acceptedNode := node.
							 child := 0 "break out of loop now we have an acceptedNode"]]]]].

	acceptedNode ~= 0 ifTrue:
		[acceptedChunk ~= 0 ifTrue:
			[self assert: (self bytesInObject: acceptedChunk) >= (chunkBytes + self allocationUnit).
			 [next := self fetchPointer: self freeChunkNextIndex ofFreeChunk: acceptedNode.
			  next ~= acceptedChunk] whileTrue:
				[acceptedNode := next].
			 self storePointer: self freeChunkNextIndex
				ofFreeChunk: acceptedNode
				withValue: (self fetchPointer: self freeChunkNextIndex ofFreeChunk: acceptedChunk).
			self freeChunkWithBytes: (self bytesInObject: acceptedChunk) - chunkBytes
					at: (self startOfObject: acceptedChunk) + chunkBytes.
			^self startOfObject: acceptedChunk].
		next := self fetchPointer: self freeChunkNextIndex ofFreeChunk: acceptedNode.
		next = 0
			ifTrue: "no list; remove the interior node"
				[self unlinkSolitaryFreeTreeNode: acceptedNode]
			ifFalse: "list; replace node with it"
				[self inFreeTreeReplace: acceptedNode with: next].
		 self assert: (self bytesInObject: acceptedNode) >= (chunkBytes + self allocationUnit).
		 self freeChunkWithBytes: (self bytesInObject: acceptedNode) - chunkBytes
				at: (self startOfObject: acceptedNode) + chunkBytes.
		^self startOfObject: acceptedNode].

	totalFreeOldSpace := totalFreeOldSpace + chunkBytes. "optimism was unfounded"
	^nil