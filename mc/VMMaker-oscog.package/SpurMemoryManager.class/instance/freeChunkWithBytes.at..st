free space
freeChunkWithBytes: bytes at: address
	<inline: true>
	| freeChunk |
	freeChunk := self initFreeChunkWithBytes: bytes at: address.
	self addToFreeList: freeChunk.
	^freeChunk