free space
freeObject: objOop
	<api>
	| bytes |
	bytes := self bytesInObject: objOop.
	totalFreeOldSpace := totalFreeOldSpace + bytes.
	^self freeChunkWithBytes: bytes at: (self startOfObject: objOop)