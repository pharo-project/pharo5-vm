allocation
allocateInterpreterChunk: byteSize 
	"Allocate a chunk of the given size. Sender must be sure that the requested size
	 includes enough space for the header word(s).  This version is for interpreter
	 allocations and will allocate beyond the interpreter's reserveStart.  If the allocation
	 takes freeStart over the scavenge threshold schedule a garbage collection."
	| newChunk newFreeStart |
	<inline: true>
	<var: #newChunk type: #usqInt>
	<var: #newFreeStart type: #usqInt>

	newChunk := freeStart.
	newFreeStart := freeStart + byteSize.
	newFreeStart < scavengeThreshold ifTrue:
		[freeStart := newFreeStart.
		 ^self oopForPointer: newChunk].

	"Don't thrash doing collections when over the scavengeThreshold.
	 Only schedule an incrementalGC if this allocation took us over the threshold."
	freeStart < scavengeThreshold ifTrue:
		[self scheduleIncrementalGC].

	newFreeStart < reserveStart ifTrue:
		[freeStart := newFreeStart.
		 ^self oopForPointer: newChunk].

	"space is low.  A scavenge may reclaim sufficient space and this may be a
	 false alarm.  We actually check for low space after the incremental collection.
	 But we really do need to do a scavenge promptly, if only to check for low
	 space.  We cannot do a garbage collect now without moving pointers under
	 the VM's feet, which is too error-prone and inefficient to contemplate."

	self scheduleIncrementalGC.

	freeStart <= endOfMemory ifTrue:
		[freeStart := newFreeStart.
		 ^self oopForPointer: newChunk].

	self error: 'out of memory'.
	^nil