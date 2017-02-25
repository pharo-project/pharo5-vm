free space
totalFreeListBytes
	"This method both computes the actual number of free bytes by traversing all free objects
	 on the free lists/tree, and checks that the tree is valid.  It is used mainly by checkFreeSpace."
	| totalFreeBytes bytesInChunk listNode nextNode |
	totalFreeBytes := 0.
	1 to: self numFreeLists - 1 do:
		[:i| 
		bytesInChunk := i * self allocationUnit.
		listNode := freeLists at: i.
		[listNode ~= 0] whileTrue:
			[totalFreeBytes := totalFreeBytes + bytesInChunk.
			 self assert: (self isValidFreeObject: listNode).
			 self assert: bytesInChunk = (self bytesInObject: listNode).
			 nextNode := self fetchPointer: self freeChunkNextIndex ofFreeChunk: listNode.
			 self assert: nextNode ~= listNode.
			 listNode := nextNode]].

	self freeTreeNodesDo:
		[:treeNode|
		 bytesInChunk := self bytesInObject: treeNode.
		 self assert: bytesInChunk / self allocationUnit >= self numFreeLists.
		 listNode := treeNode.
		 [listNode ~= 0] whileTrue:
			["self printFreeChunk: listNode"
			 self assert: (self isValidFreeObject: listNode).
			 self assert: (listNode = treeNode
						  or: [(self fetchPointer: self freeChunkParentIndex ofFreeChunk: listNode) = 0]).
			 totalFreeBytes := totalFreeBytes + bytesInChunk.
			 self assert: bytesInChunk = (self bytesInObject: listNode).
			 nextNode := self fetchPointer: self freeChunkNextIndex ofFreeChunk: listNode.
			 self assert: nextNode ~= listNode.
			 listNode := nextNode].
		 treeNode].
	^totalFreeBytes