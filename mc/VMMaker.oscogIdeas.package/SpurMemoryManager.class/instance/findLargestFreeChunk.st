free space
findLargestFreeChunk
	"Answer, but do not remove, the largest free chunk in the free lists."
	| treeNode childNode |
	treeNode := freeLists at: 0.
	treeNode = 0 ifTrue:
		[^nil].
	[self assert: (self isValidFreeObject: treeNode).
	 self assert: (self bytesInObject: treeNode) >= (self numFreeLists * self allocationUnit).
	 childNode := self fetchPointer: self freeChunkLargerIndex ofFreeChunk: treeNode.
	 childNode ~= 0] whileTrue:
		[treeNode := childNode].
	^treeNode