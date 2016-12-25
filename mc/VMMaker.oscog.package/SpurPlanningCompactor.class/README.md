SpurPlanningCompactor implements the classic planning compaction algorithm for Spur.  It makes at least three passes through the heap.  The first pass plans where live movable objects will go, copying their forwarding field to the next slot in savedFirstFieldsSpace, and setting their forwarding pointer to point to their eventual location.  The second pass updates all pointers in live pointer objects to point to objects' final destinations.  The third pass moves objects to their final positions, unmarking objects as it does so.  If the forwarding fields of live objects in the to-be-moved portion of the entire heap won't fit in savedFirstFieldsSpace, then additional passes are made until the entire heap has been compacted.

Instance Variables
	biasForGC						<Boolean>
	coInterpreter:					<StackInterpreter>
	firstFieldOfRememberedSet		<Oop>
	firstFreeObject					<Oop>
	firstMobileObject				<Oop>
	lastMobileObject				<Oop>
	manager:						<SpurMemoryManager>
	savedFirstFieldsSpace				<SpurContiguousObjStack>
	savedFirstFieldsSpaceWasAllocated	<Boolean>
	scavenger:						<SpurGenerationScavenger>

biasForGC
	- true if compacting for GC, in which case do only one pass, or false if compacting for snapshot, in which case do as many passes as necessary to compact the entire heap.

firstFieldOfRememberedSet
	- the saved first field of the rememberedSet.  The rememberedSet must be relocated specially because it is not a pointer object.  And hence the first field needs to be extracted for proper relocation.

firstFreeObject
	- the first free object in a compaction pass.

firstMobileObject
	- the first mobile object in a compaction.  Unpinned objects from the firstMobileObject through to the lastMobileObject are implicitly forwarded.

lastMobileObject
	- the last mobile object in a compaction.  Unpinned objects from the firstMobileObject through to the lastMobileObject are implicitly forwarded.

savedFirstFieldsSpace
	- the space holding the saved first fields, each overwritten by a forwarding pointer, for the objects from firstMobileObject through to lastMobileObject.

savedFirstFieldsSpaceWasAllocated
	- if true, the memory for savedFirstFieldsSpace was obtained via a call of sqAllocateMemorySegmentOfSize:Above:AllocatedSizeInto: