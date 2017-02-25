SpurSlidingCompactor compacts memory completely by sliding objects down in memory.  It does so by using a buffer (compactedCopySpace) to hold a copy of compacted objects in some region of the heap being compacted.  Starting at the first object above free space (up until a pinned object), objects are copied into CCS until it fills up, and as objects are copied, their originals are forwarded to the location they would occupy.  Once the CCS is full, or all of the heap has been copied to it, memory is scanned searching for oops in the range being compacted, and oops are updated to their actual positions.  Then the contents of the CCS are block copied into place.  The process repeats until all of the heap has been compacted.  This will leave one contiguous free chunk in the topmost occupied segment (ignoring pinned objects).  The number of passes made to follow forwarders is approximately the allocated size of the heap divided by the size of CCS; the larger CCS the more objects that can be compacted in one go (ignoring the effect of pinned objects).

Instance Variables
	coInterpreter:				<StackInterpreter>
	compactedCopySpace:		<SpurNewSpaceSpace>
	manager:					<SpurMemoryManager>
	scavenger:					<SpurGenerationScavenger>

compactedCopySpace
	- a large contiguous region of memory used to copy objects into during compaction.  The compactor may try and allocate a segment, use a large free chunk or use eden for this memory.