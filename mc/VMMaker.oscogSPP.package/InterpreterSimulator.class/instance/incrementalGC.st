debug support
incrementalGC
	transcript cr; nextPutAll: 'incrementalGC ('; print: byteCount; nextPut: $); flush.
	^super incrementalGC