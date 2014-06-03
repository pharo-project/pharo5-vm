free space
allObjectsInFreeTree: freeNode do: aBlock
	| listNode |
	freeNode = 0 ifTrue: [^0].
	listNode := freeNode.
	[listNode ~= 0] whileTrue:
		[aBlock value: listNode.
		 listNode := self fetchPointer: self freeChunkNextIndex ofFreeChunk: listNode].
	self allObjectsInFreeTree: (self fetchPointer: self freeChunkSmallerIndex ofFreeChunk: freeNode)
		do: aBlock.
	self allObjectsInFreeTree: (self fetchPointer: self freeChunkLargerIndex ofFreeChunk: freeNode)
		do: aBlock