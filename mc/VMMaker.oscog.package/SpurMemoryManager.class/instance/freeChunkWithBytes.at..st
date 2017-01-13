free space
freeChunkWithBytes: bytes at: address
	<inline: false>
	| freeChunk |
	self assert: (self isInOldSpace: address).
	freeChunk := self initFreeChunkWithBytes: bytes at: address.
	self assert: (segmentManager segmentContainingObj: freeChunk) = (segmentManager segmentContainingObj: (self addressAfter: freeChunk)).
	self addToFreeList: freeChunk bytes: bytes.
	self assert: freeChunk = (self objectStartingAt: address).
	^freeChunk