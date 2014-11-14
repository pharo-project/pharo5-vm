free space
addFreeSubTree: freeTree
	"Add a freeChunk sub tree back into the large free chunk tree.
	 This is for allocateOldSpaceChunkOf[Exactly]Bytes:[suchThat:]."
	| bytesInArg treeNode bytesInNode subNode |
	"N.B. *can't* use numSlotsOfAny: because of rounding up of odd slots
	 and/or step in size at 1032 bytes in 32-bits or 2048 bytes in 64-bits."
	self assert: (self isFreeObject: freeTree).
	bytesInArg := self bytesInObject: freeTree.
	self assert: bytesInArg >= (self numFreeLists * self allocationUnit).
	treeNode := freeLists at: 0.
	self assert: treeNode ~= 0.
	[bytesInNode := self bytesInObject: treeNode.
	 "check for overlap; could write this as self oop: (self objectAfter: freeChunk) isLessThanOrEqualTo: child...
	  but that relies on headers being correct, etc.  So keep it clumsy..."
	 self assert: ((self oop: freeTree + bytesInArg - self baseHeaderSize isLessThanOrEqualTo: treeNode)
					or: [self oop: freeTree isGreaterThanOrEqualTo: treeNode + bytesInNode - self baseHeaderSize]).
	 self assert: bytesInNode >= (self numFreeLists * self allocationUnit).
	 self assert: bytesInArg ~= bytesInNode.
	 bytesInNode > bytesInArg
		ifTrue:
			[subNode := self fetchPointer: self freeChunkSmallerIndex ofFreeChunk: treeNode.
			 subNode = 0 ifTrue:
				[self storePointer: self freeChunkSmallerIndex ofFreeChunk: treeNode withValue: freeTree.
				 self storePointer: self freeChunkParentIndex ofFreeChunk: freeTree withValue: treeNode.
				 ^self]]
		ifFalse:
			[subNode := self fetchPointer: self freeChunkLargerIndex ofFreeChunk: treeNode.
			 subNode = 0 ifTrue:
				[self storePointer: self freeChunkLargerIndex ofFreeChunk: treeNode withValue: freeTree.
				 self storePointer: self freeChunkParentIndex ofFreeChunk: freeTree withValue: treeNode.
				 ^self]].
	 treeNode := subNode] repeat