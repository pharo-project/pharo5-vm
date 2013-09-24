free space
freeObject: objOop
	| bytes |
	bytes := self bytesInObject: objOop.
	totalFreeOldSpace := totalFreeOldSpace + bytes.
	^self freeChunkWithBytes: bytes at: (self startOfObject: objOop)