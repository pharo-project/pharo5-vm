free space
inFreeTreeReplace: treeNode with: newNode
	"Part of reorderReversedTreeList:.  Switch treeNode with newNode in
	 the tree, but do nothing to the list linked through freeChunkNextIndex."
	| relative |
	"copy parent, smaller, larger"
	self freeChunkParentIndex to: self freeChunkLargerIndex do:
		[:i|
		relative := self fetchPointer: i ofFreeChunk: treeNode.
		i = self freeChunkParentIndex
			ifTrue:
				[relative = 0
					ifTrue: "update root to point to newNode"
						[self assert: (freeLists at: 0) = treeNode.
						 freeLists at: 0 put: newNode]
					ifFalse: "replace link from parent to treeNode with link to newNode."
						[self storePointer: (treeNode = (self fetchPointer: self freeChunkSmallerIndex ofFreeChunk: relative)
												ifTrue: [self freeChunkSmallerIndex]
												ifFalse: [self freeChunkLargerIndex])
							ofFreeChunk: relative
							withValue: newNode]]
			ifFalse:
				[relative ~= 0 ifTrue:
					[self assert: (self fetchPointer: self freeChunkParentIndex ofFreeChunk: relative) = treeNode.
					 self storePointer: self freeChunkParentIndex ofFreeChunk: relative withValue: newNode]].
		self storePointer: i ofFreeChunk: newNode withValue: relative.
		self storePointer: i ofFreeChunk: treeNode withValue: 0]