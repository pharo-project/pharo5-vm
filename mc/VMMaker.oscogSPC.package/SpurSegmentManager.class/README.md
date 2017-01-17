Instances of SpurSegmentManager manage oldSpace, which is organized as a sequence of segments.  Segments can be obtained from the operating system and returned to the operating system when empty and shrinkage is required.  Segments are kept invisible from the SpurMemoryManager by using "bridge" objects, "fake" pinned objects to bridge the gaps between segments.  A pinned object header occupies the last 16 bytes of each segment, and the pinned object's size is the distance to the start of the next segment.  So when the memory manager enumerates objects it skips over these bridges and memory appears linear.  The constraint is that segments obtained from the operating system must be at a higher address than the first segment.  The maximum size of large objects, being an overflow slot size, should be big enough to bridge the gaps, because in 32-bits the maximum size is 2^32 slots.  In 64-bits the maximum size of large objects is 2^56 slots, or 2^59 bits, which we hope will suffice.

When an image is written to a snapshot file the second word of the header of the bridge at the end of each segment is replaced by the size of the following segment, the segments are written to the file, and the second word of each bridge is restored.  Hence the length of each segment is derived from the bridge at the end of the preceeding segment.  The length of the first segment is stored in the image header as firstSegmentBytes.  The start of each segment is also derived from the bridge as a delta from the start of the previous segment.  The start of The first segment is stored in the image header as startOfMemory.

On load all segments are read into one single segment, eliminating the bridge objects, and computing the swizzle distance for each segment, based on where the segments were in memory when the image file was written, and where the coalesced segment ends up on load.  Then the segment is traversed, swizzling pointers by selecting the relevant swizzle for each oop's segment.

Instance Variables
	manager:					<SpurMemoryManager>
	numSegments:				<Integer>
	numSegInfos:				<Integer>
	segments:					<Array of SpurSegmentInfo>
	firstSegmentSize:			<Integer>
	canSwizzle:					<Boolean>
	sweepIndex:				<Integer>
	preferredPinningSegment:	<SpurSegmentInfo>

canSwizzle
	- a flag set and cleared during initialization to validate that swizzling is only performed at the right time

firstSegmentSize
	- the size of the first segment when loading an image

manager
	- the memory manager the receiver manages segments for (simulation only)
	
numSegInfos
	- the size of the segments array in units of SpurSegmentInfo size
	
numSegments
	- the number of segments (the number of used entries in segments, <= numSegInfos)

preferredPinningSegment
	- the segment in which objects should be copied when pinned, so as to cluster pinned objects in as few segments as possible.  As yet unimplemented.

segments
	- the start addresses, lengths and offsets to adjust oops on image load, for each segment

sweepIndex
	- a segment index used to optimize setting the containsPinned flag on segments during freeUnmarkedObjectsAndSortAndCoalesceFreeSpace