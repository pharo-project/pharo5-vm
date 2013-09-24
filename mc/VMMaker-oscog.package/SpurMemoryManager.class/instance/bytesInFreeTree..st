free space
bytesInFreeTree: freeNode
	| freeBytes bytesInObject next |
	freeNode = 0 ifTrue: [^0].
	freeBytes := 0.
	bytesInObject := self bytesInObject: freeNode.
	self assert: bytesInObject / self allocationUnit >= NumFreeLists.
	next := freeNode.
	[next ~= 0] whileTrue:
		[freeBytes := freeBytes + bytesInObject.
		 self assert: bytesInObject = (self bytesInObject: next).
		 next := self fetchPointer: self freeChunkNextIndex ofFreeChunk: next].
	^freeBytes
	+ (self bytesInFreeTree: (self fetchPointer: self freeChunkSmallerIndex ofFreeChunk: next))
	+ (self bytesInFreeTree: (self fetchPointer: self freeChunkLargerIndex ofFreeChunk: next))