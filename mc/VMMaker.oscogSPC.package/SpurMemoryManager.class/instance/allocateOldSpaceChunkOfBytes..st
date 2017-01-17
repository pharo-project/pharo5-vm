free space
allocateOldSpaceChunkOfBytes: chunkBytes
	"Answer a chunk of oldSpace from the free lists, if available,
	 otherwise answer nil.  Break up a larger chunk if one of the
	 exact size does not exist.  N.B.  the chunk is simply a pointer, it
	 has no valid header.  The caller *must* fill in the header correctly."
	<var: #chunkBytes type: #usqInt>
	| initialIndex chunk index nodeBytes parent child |
	"for debugging:" "totalFreeOldSpace := self totalFreeListBytes"
	totalFreeOldSpace := totalFreeOldSpace - chunkBytes. "be optimistic (& don't wait for the write)"
	initialIndex := chunkBytes / self allocationUnit.
	(initialIndex < self numFreeLists and: [1 << initialIndex <= freeListsMask]) ifTrue:
		[(freeListsMask anyMask: 1 << initialIndex) ifTrue:
			[(chunk := freeLists at: initialIndex) ~= 0 ifTrue:
				[self assert: chunk = (self startOfObject: chunk).
				 self assert: (self isValidFreeObject: chunk).
				^self unlinkFreeChunk: chunk atIndex: initialIndex].
			 freeListsMask := freeListsMask - (1 << initialIndex)].
		 "first search for free chunks of a multiple of chunkBytes in size"
		 index := initialIndex.
		 [(index := index + index) < self numFreeLists
		  and: [1 << index <= freeListsMask]] whileTrue:
			[(freeListsMask anyMask: 1 << index) ifTrue:
				[(chunk := freeLists at: index) ~= 0 ifTrue:
					[self assert: chunk = (self startOfObject: chunk).
					 self assert: (self isValidFreeObject: chunk).
					 self unlinkFreeChunk: chunk atIndex: index.
					 self assert: (self bytesInObject: chunk) = (index * self allocationUnit).
					 self freeChunkWithBytes: index * self allocationUnit - chunkBytes
						at: (self startOfObject: chunk) + chunkBytes.
					^chunk].
				 freeListsMask := freeListsMask - (1 << index)]].
		 "now get desperate and use the first that'll fit.
		  Note that because the minimum free size is 16 bytes (2 * allocationUnit), to
		  leave room for the forwarding pointer/next free link, we can only break chunks
		  that are at least 16 bytes larger, hence start at initialIndex + 2."
		 index := initialIndex + 1.
		 [(index := index + 1) < self numFreeLists
		  and: [1 << index <= freeListsMask]] whileTrue:
			[(freeListsMask anyMask: 1 << index) ifTrue:
				[(chunk := freeLists at: index) ~= 0 ifTrue:
					[self assert: chunk = (self startOfObject: chunk).
					 self assert: (self isValidFreeObject: chunk).
					 self unlinkFreeChunk: chunk atIndex: index.
					 self assert: (self bytesInObject: chunk) = (index * self allocationUnit).
					 self freeChunkWithBytes: index * self allocationUnit - chunkBytes
						at: (self startOfObject: chunk) + chunkBytes.
					^chunk].
				 freeListsMask := freeListsMask - (1 << index)]]].

	"Large chunk, or no space on small free lists.  Search the large chunk list.
	 Large chunk list organized as a tree, each node of which is a list of chunks
	 of the same size. Beneath the node are smaller and larger blocks.
	 When the search ends parent should hold the smallest chunk at least as
	 large as chunkBytes, or 0 if none."
	parent := 0.
	child := freeLists at: 0.
	[child ~= 0] whileTrue:
		[| childBytes |
		 self assert: (self isValidFreeObject: child).
		 childBytes := self bytesInObject: child.
		 childBytes = chunkBytes
			ifTrue: "size match; try to remove from list at node."
				[chunk := self fetchPointer: self freeChunkNextIndex
								ofFreeChunk: child.
				 chunk ~= 0 ifTrue:
					[self assert: (self isValidFreeObject: chunk).
					 self storePointer: self freeChunkNextIndex
						ofFreeChunk: child
						withValue: (self fetchPointer: self freeChunkNextIndex
										ofFreeChunk: chunk).
					 ^self startOfObject: chunk].
				 nodeBytes := childBytes.
				 parent := child.
				 child := 0] "break out of loop to remove interior node"
			ifFalse:
				["Note that because the minimum free size is 16 bytes (2 * allocationUnit), to
				  leave room for the forwarding pointer/next free link, we can only break chunks
				  that are at least 16 bytes larger, hence reject chunks < 2 * allocationUnit larger."
				childBytes <= (chunkBytes + self allocationUnit)
					ifTrue: "node too small; walk down the larger size of the tree"
						[child := self fetchPointer: self freeChunkLargerIndex ofFreeChunk: child]
					ifFalse:
						[parent := child. "parent will be smallest node >= chunkBytes + allocationUnit"
						 nodeBytes := childBytes.
						 child := self fetchPointer: self freeChunkSmallerIndex ofFreeChunk: child]]].
	parent = 0 ifTrue:
		[totalFreeOldSpace := totalFreeOldSpace + chunkBytes. "optimism was unfounded"
		 ^nil].

	"self printFreeChunk: parent"
	self assert: (nodeBytes = chunkBytes or: [nodeBytes >= (chunkBytes + (2 * self allocationUnit))]).
	self assert: (self bytesInObject: parent) = nodeBytes.

	"attempt to remove from list"
	chunk := self fetchPointer: self freeChunkNextIndex ofFreeChunk: parent.
	chunk ~= 0 ifTrue:
		[self assert: (chunkBytes = nodeBytes or: [chunkBytes + self allocationUnit < nodeBytes]).
		 self storePointer: self freeChunkNextIndex
			ofFreeChunk: parent
			withValue: (self fetchPointer: self freeChunkNextIndex
							ofFreeChunk: chunk).
		 chunkBytes ~= nodeBytes ifTrue:
			[self freeChunkWithBytes: nodeBytes - chunkBytes
					at: (self startOfObject: chunk) + chunkBytes].
		 ^self startOfObject: chunk].

	"no list; remove the interior node"
	chunk := parent.
	self unlinkSolitaryFreeTreeNode: chunk.

	"if there's space left over, add the fragment back."
	chunkBytes ~= nodeBytes ifTrue:
		[self freeChunkWithBytes: nodeBytes - chunkBytes
				at: (self startOfObject: chunk) + chunkBytes].
	^self startOfObject: chunk