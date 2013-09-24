free space
allocateOldSpaceChunkOfBytes: chunkBytes
	"Answer a chunk of oldSpace from the free lists, if available,
	 otherwise answer nil.  N.B.  the chunk is simply a pointer, it has
	 no valid header.  The caller *must* fill in the header correctly."
	| index chunk nextIndex nodeBytes parent child smaller larger |
	totalFreeOldSpace := totalFreeOldSpace - chunkBytes. "be optimistic (& don't wait for the write)"
	index := chunkBytes / self allocationUnit.
	(index < NumFreeLists and: [1 << index <= freeListsMask]) ifTrue:
		[(chunk := freeLists at: index) ~= 0 ifTrue:
			[self assert: chunk = (self startOfObject: chunk).
			^self unlinkFreeChunk: chunk atIndex: index].
		 "first search for free chunks of a multiple of chunkBytes in size"
		 nextIndex := index.
		 [1 << index <= freeListsMask
		  and: [(nextIndex := nextIndex + index) < NumFreeLists]] whileTrue:
			[((freeListsMask anyMask: 1 << index)
			 and: [(chunk := freeLists at: index) ~= 0]) ifTrue:
				[self assert: chunk = (self startOfObject: chunk).
				 self unlinkFreeChunk: chunk atIndex: index.
				 self assert: (self bytesInObject: chunk) = index * self allocationUnit.
				 self freeChunkWithBytes: index * self allocationUnit - chunkBytes
					at: (self startOfObject: chunk) + chunkBytes.
				^chunk]].
		 "now get desperate and use the first that'll fit"
		 nextIndex := index.
		 [1 << index >= freeListsMask
		  and: [(nextIndex := nextIndex + 1) < NumFreeLists]] whileTrue:
			[(freeListsMask anyMask: 1 << index) ifTrue:
				[(chunk := freeLists at: index) ~= 0 ifTrue:
					[self assert: chunk = (self startOfObject: chunk).
					 self unlinkFreeChunk: chunk atIndex: index.
					 self assert: (self bytesInObject: chunk) = index * self allocationUnit.
					 self freeChunkWithBytes: index * self allocationUnit - chunkBytes
						at: (self startOfObject: chunk) + chunkBytes.
					^chunk].
				 freeListsMask := freeListsMask - (1 << index)]]].

	"Large chunk, or no space on small free lists.  Search the large chunk list.
	 Large chunk list organized as a tree, each node of which is a list of chunks
	 of the same size. Beneath the node are smaller and larger blocks."
	parent := 0.
	child := freeLists at: 0.
	[child ~= 0] whileTrue:
		[nodeBytes := self bytesInObject: child.
		 parent := child.
		 nodeBytes = chunkBytes
			ifTrue: "size match; try to remove from list at node."
				[chunk := self fetchPointer: self freeChunkNextIndex
								ofFreeChunk: child.
				 chunk ~= 0 ifTrue:
					[self storePointer: self freeChunkNextIndex
						ofFreeChunk: child
						withValue: (self fetchPointer: self freeChunkNextIndex
										ofFreeChunk: chunk).
					 ^self startOfObject: chunk].
				 child := 0] "break out of loop to remove interior node"
			ifFalse:"walk down the tree"
				[child := self fetchPointer: (nodeBytes > chunkBytes
												ifTrue: [self freeChunkSmallerIndex]
												ifFalse: [self freeChunkLargerIndex])
								ofFreeChunk: child]].
	parent = 0 ifTrue:
		[totalFreeOldSpace := totalFreeOldSpace + chunkBytes. "optimism was unfounded"
		 self halt].

	"self printFreeChunk: parent"
	self assert: (self bytesInObject: parent) = nodeBytes.
	"attempt to remove from list"
	chunk := self fetchPointer: self freeChunkNextIndex
					ofFreeChunk: parent.
	chunk ~= 0 ifTrue:
		[self storePointer: self freeChunkNextIndex
			ofFreeChunk: parent
			withValue: (self fetchPointer: self freeChunkNextIndex
							ofFreeChunk: chunk).
		 chunkBytes ~= nodeBytes ifTrue:
			[self freeChunkWithBytes: nodeBytes - chunkBytes
					at: (self startOfObject: chunk) + chunkBytes].
		 ^self startOfObject: chunk].
	"no list; remove an interior node"
	chunk := parent.
	parent := self fetchPointer: self freeChunkParentIndex ofFreeChunk: chunk.
	"no parent; stitch the subnodes back into the root"
	parent = 0 ifTrue:
		[smaller := self fetchPointer: self freeChunkSmallerIndex ofFreeChunk: chunk.
		 larger := self fetchPointer: self freeChunkLargerIndex ofFreeChunk: chunk.
		 smaller = 0
			ifTrue: [freeLists at: 0 put: larger]
			ifFalse:
				[freeLists at: 0 put: smaller.
				 larger ~= 0 ifTrue:
					[self addFreeSubTree: larger]].
		"coInterpreter transcript ensureCr.
		 coInterpreter print: 'new free tree root '.
		 (freeLists at: 0) = 0 ifTrue: [coInterpreter print: '0'] ifFalse: [self printFreeChunk: (freeLists at: 0)].
		 coInterpreter cr."
		 chunkBytes ~= nodeBytes ifTrue:
			[self freeChunkWithBytes: nodeBytes - chunkBytes
					at: (self startOfObject: chunk) + chunkBytes].
		 ^self startOfObject: chunk].
	"remove node from tree; reorder tree simply.  two cases (which have mirrors, for four total):
	 case 1. interior node has one child, P = parent, N = node, S = subtree (mirrored for large vs small)
			___				  ___
			| P |				  | P |
		    _/_				_/_
		    | N |		=>		| S |
		 _/_
		 | S |"
	self halt.
	"case 2: interior node has two children, , P = parent, N = node, L = smaller, left subtree, R = larger, right subtree.
	 add the left subtree to the bottom left of the right subtree (mirrored for large vs small) 
			___				  ___
			| P |				  | P |
		    _/_				_/_
		    | N |		=>		| R |
		 _/_  _\_		    _/_
		 | L | | R |		    | L |"
	self halt