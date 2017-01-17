free space
detachFreeObject: freeChunk
	"This is a rare operation, so its efficiency isn't critical.
	 Having a valid prev link for tree nodes would help."
	<inline: false>
	| chunkBytes result |
	chunkBytes := self bytesInObject: freeChunk.
	result := self allocateOldSpaceChunkOfExactlyBytes: chunkBytes suchThat: [:f| f = freeChunk].
	self assert: result = (self startOfObject: freeChunk)