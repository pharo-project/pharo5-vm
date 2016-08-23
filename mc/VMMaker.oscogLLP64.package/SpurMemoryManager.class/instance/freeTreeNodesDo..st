free space
freeTreeNodesDo: aBlock
	"Enumerate all nodes in the free tree (in order, smaller to larger),
	 but *not* including the next nodes of the same size off each tree node.
	 This is an iterative version so that the block argument can be
	 inlined by Slang. The trick to an iterative binary tree application is
	 to apply the function on the way back up when returning from a
	 particular direction, in this case up from the larger child.

	 N.B For the convenience of rebuildFreeTreeFromSortedFreeChunks
	 aBlock *MUST* answer the freeTreeNode it was invoked with, or
	 its replacement if it was replaced by aBlock."
	<inline: true>
	| treeNode cameFrom |
	treeNode := freeLists at: 0.
	treeNode = 0 ifTrue:
		[^self].
	cameFrom := -1.
	[| smallChild largeChild |
	 self assert: (self bytesInObject: treeNode) >= (self numFreeLists * self allocationUnit).
	 smallChild := self fetchPointer: self freeChunkSmallerIndex ofFreeChunk: treeNode.
	 largeChild := self fetchPointer: self freeChunkLargerIndex ofFreeChunk: treeNode.
	 self assert: (smallChild = 0 or: [treeNode = (self fetchPointer: self freeChunkParentIndex ofFreeChunk: smallChild)]).
	 self assert: (largeChild = 0 or: [treeNode = (self fetchPointer: self freeChunkParentIndex ofFreeChunk: largeChild)]).
	 "apply if the node has no children, or it has no large children and we're
	  returning from the small child, or we're returning from the large child."
	 ((smallChild = 0 and: [largeChild = 0])
	  or: [largeChild = 0
			ifTrue: [cameFrom = smallChild]
			ifFalse: [cameFrom = largeChild]])
		ifTrue:
			[treeNode := aBlock value: treeNode.
			 "and since we've applied we must move on up"
			 cameFrom := treeNode.
			 treeNode := self fetchPointer: self freeChunkParentIndex ofFreeChunk: treeNode]
		ifFalse:
			[(smallChild ~= 0 and: [cameFrom ~= smallChild])
				ifTrue:
					[treeNode := smallChild]
				ifFalse:
					[self assert: largeChild ~= 0.
					 treeNode := largeChild].
			 cameFrom := -1].
	 treeNode ~= 0] whileTrue