sista support
allocateCounters: nCounters
	"On Spur allocate the counters on the heap as pinned objects.
	 Each counter occupies 32-bits.  The number of counters can
	 be derived from the number of slots in the obj."
	<inline: true>
	| objOop |
	objOop := objectMemory allocatePinnedSlots: nCounters + 1 // 2.
	^objOop
		ifNil: [0]
		ifNotNil: [objOop + objectMemory baseHeaderSize]