debug support
incrementalGC
	coInterpreter transcript cr; nextPutAll: 'incrementalGC ('; print: coInterpreter byteCount; space; print: freeStart; nextPut: $); flush.
	^super incrementalGC