allocation
allocateChunk: byteSize 
	"Allocate a chunk of the given size. Sender must be sure that the requested size
	 includes enough space for the header word(s).  This version is for normal allocations
	 and refuses to allocate beyond the interpreter's reserveStart.  If the allocation takes
	 freeStart over the scavenge threshold schedule a garbage collection.  If this returns 0
	 the client should prepare for garbage collection and retry using allocateChunkAfterGC:"
	| newChunk newFreeStart |
	<inline: true>
	<var: #newChunk type: #usqInt>
	<var: #newFreeStart type: #usqInt>
	newChunk := freeStart.
	newFreeStart := freeStart + byteSize.
	newFreeStart < scavengeThreshold ifTrue:
		[freeStart := newFreeStart.
		 ^self oopForPointer: newChunk].

	self scheduleIncrementalGC.
	freeStart <= reserveStart ifTrue:
		[freeStart := newFreeStart.
		 ^self oopForPointer: newChunk].

	^0