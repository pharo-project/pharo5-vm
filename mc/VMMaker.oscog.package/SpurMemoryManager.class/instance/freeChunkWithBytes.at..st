free space
freeChunkWithBytes: bytes at: address
	<inline: false>
	| freeChunk |
	self assert: (self isInOldSpace: address).
	self assert: (segmentManager segmentContainingObj: address) = (segmentManager segmentContainingObj: address + bytes).
	freeChunk := self initFreeChunkWithBytes: bytes at: address.
	self addToFreeList: freeChunk bytes: bytes.
	self assert: freeChunk = (self objectStartingAt: address).
	^freeChunk