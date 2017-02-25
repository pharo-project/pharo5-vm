free space
reorderReversedTreeList: treeNode
	"Once the freeTree has been rebuilt from the sortedFreeChunks list
	 each list will be in a weird order, the list in reverse order, high to low,
	 but the tree node, because it is inserted first, will be the lowest address.
	 Reverse the list so it is sorted low to high, but make the highest address
	 node the first, as this will be allocated from last."
	| first next node prev |
	"first becomes the new head, as this is the last one we want to allocate and we allocate from the list first."
	first := self fetchPointer: self freeChunkNextIndex ofFreeChunk: treeNode.
	"no next node, so no change"
	first = 0 ifTrue:
		[^treeNode].
	node := self fetchPointer: self freeChunkNextIndex ofFreeChunk: first.
	self storePointer: self freeChunkNextIndex ofFreeChunk: first withValue: treeNode.
	self inFreeTreeReplace: treeNode with: first.
	prev := 0.
	[node ~= 0] whileTrue:
		[next := self fetchPointer: self freeChunkNextIndex ofFreeChunk: node.
		 self storePointer: self freeChunkNextIndex ofFreeChunk: node withValue: prev.
		 prev := node.
		 node := next].
	self storePointer: self freeChunkNextIndex ofFreeChunk: treeNode withValue: prev.
	^first