debug support
tenuringIncrementalGC
	transcript cr; nextPutAll: 'tenuringIncrementalGC ('; print: byteCount; nextPut: $); flush.
	^super tenuringIncrementalGC