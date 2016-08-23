free space
addFreeChunkWithBytes: bytes at: address
	self freeChunkWithBytes: bytes at: address.
	totalFreeOldSpace := totalFreeOldSpace + bytes