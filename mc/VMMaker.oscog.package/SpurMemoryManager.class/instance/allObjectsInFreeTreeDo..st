free space
allObjectsInFreeTreeDo: aBlock
	"Enumerate all objects in the free tree (in order, smaller to larger).
	 This is an iterative version so that the block argument can be
	 inlined by Slang. The trick to an iterative binary tree application is
	 to apply the function on the way back up when returning from a
	 particular direction, in this case up from the larger child."
	<inline: true>
	self freeTreeNodesDo:
		[:freeTreeNode| | next |
		 next := freeTreeNode.
		 [aBlock value: next.
		  next := self fetchPointer: self freeChunkNextIndex ofFreeChunk: next.
		  next ~= 0] whileTrue.
		 freeTreeNode]