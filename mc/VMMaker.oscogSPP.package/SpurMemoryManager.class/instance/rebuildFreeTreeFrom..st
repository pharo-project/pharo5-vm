free space
rebuildFreeTreeFrom: sortedFreeChunks
	"post sweep and pre compact, rebuild the large free chunk tree from the
	 sortedFreeChunks list, such that the lists are ordered from low to high address."
	| freeChunk bytes totalBytes |
	"first add all the chunks to the tree.  This will result in almost address-sorted lists.
	 We will need to reorder the lists."
	freeChunk := sortedFreeChunks.
	totalBytes := 0.
	[freeChunk ~= 0] whileTrue:
		[bytes := self bytesInObject: freeChunk.
		 totalBytes := totalBytes + bytes.
		 self addToFreeTree: freeChunk bytes: bytes.
		 freeChunk := self fetchPointer: self freeChunkNextAddressIndex
							ofFreeChunk: freeChunk].
	"now reorder the lists to ensure they're in address order, apart from the list head, which should be highest."
	self freeTreeNodesDo:
		[:treeNode| | newTreeNode |
		newTreeNode := self reorderReversedTreeList: treeNode.
		newTreeNode].
	^totalBytes