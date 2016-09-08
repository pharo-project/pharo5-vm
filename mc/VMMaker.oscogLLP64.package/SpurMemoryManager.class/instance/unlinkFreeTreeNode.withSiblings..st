free space
unlinkFreeTreeNode: freeTreeNode withSiblings: next
	"Unlink a freeTreeNode.  Assumes the node has a list (non-null next link)."
	| parent smaller larger |
	parent := self fetchPointer: self freeChunkParentIndex ofObject: freeTreeNode.
	smaller := self fetchPointer: self freeChunkSmallerIndex ofObject: freeTreeNode.
	larger := self fetchPointer: self freeChunkLargerIndex ofObject: freeTreeNode.
	parent = 0
		ifTrue: [freeLists at: 0 put: next]
		ifFalse:
			[self storePointer: (freeTreeNode = (self fetchPointer: self freeChunkSmallerIndex
												ofObject: parent)
									ifTrue: [self freeChunkSmallerIndex]
									ifFalse: [self freeChunkLargerIndex])
				ofFreeChunk: parent
				withValue: next.
			  self storePointer: self freeChunkParentIndex ofFreeChunk: next withValue: parent].
	self storePointer: self freeChunkSmallerIndex ofFreeChunk: next withValue: smaller.
	smaller ~= 0 ifTrue:
		[self storePointer: self freeChunkParentIndex ofFreeChunk: smaller withValue: next].
	self storePointer: self freeChunkLargerIndex ofFreeChunk: next withValue: larger.
	larger ~= 0 ifTrue:
		[self storePointer: self freeChunkParentIndex ofFreeChunk: larger withValue: next]