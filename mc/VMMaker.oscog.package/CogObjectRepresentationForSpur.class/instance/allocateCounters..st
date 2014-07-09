sista support
allocateCounters: nCounters
	"On Spur allocate the counters on the heap as pinned objects.  The
	 number of counters can be derived from the nbumber of slots in the obj."
	<inline: true>
	| objOop |
	objOop := objectMemory allocatePinnedCounters: nCounters.
	^objOop
		ifNil: [0]
		ifNotNil: [objOop + objectMemory baseHeaderSize]