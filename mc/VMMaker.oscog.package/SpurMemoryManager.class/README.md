SpurMemoryManager is a new object representation and garbage collector for the Cog VM's.  Spur is dedicated to Andreas Raab, friend and colleague.  I miss you, Andreas.  The goal for Spur is an overall improvement in Cog of -50% (twice as fast) for memory-intensive benchmarks.  

A detailed design sketch is included below after the instance variable descriptions.  The instance variable declarations can be checked for extra and missing declarations by making a literal array out of them and using
	| ivs |
	ivs := (#(becomeEffectsFlags		<Integer> ...) piecesCutWhere: [:a :b| a = #>]) collect: [:ea| ea first].
	{ivs reject: [:iv| SpurMemoryManager instVarNames includes: iv].
	(SpurMemoryManager instVarNames reject: [:iv| ivs includes: iv]) sort}
The instance variable descriptions can be checked for extra and missing declarations by making a literal string out of them and using
	| ivs |
	ivs := ('becomeEffectsFlags...' piecesCutWhere: [:a :b| a = Character cr]) select: [:s| s notEmpty and: [s first isLetter]] thenCollect: [:ea| ea withoutTrailingBlanks].
	{ivs reject: [:iv| SpurMemoryManager instVarNames includes: iv].
	(SpurMemoryManager instVarNames reject: [:iv| ivs includes: iv]) sort}

Instance Variables
	becomeEffectsFlags		<Integer>
	checkForLeaks				<Boolean>
	classTableBitmap			<CArrayAccessor on: ByteArray>
	classTableFirstPage		<Integer oop>
	classTableIndex			<Integer>
	coInterpreter				<StackInterpreter|CoInterpreter (StackInterpreterSimulator|CogVMSimulator)>
	edenBytes					<Integer>
	endOfMemory				<Integer address>
	ephemeronQueue			<Integer objStack oop>
	extraRootCount			<Integer>
	extraRoots					<Array of: oop>
	falseObj					<Integer oop>
	firstFreeChunk				<Integer oop|nil>
	freeLists					<CArray on: memory>
	freeListsMask				<Integer>
	freeOldSpaceStart			<Integer address>
	freeStart					<Integer address>
	gcStartUsecs				<Integer>
	growHeadroom				<Integer>
	heapMap					<CogCheck32BitHeapMap>
	hiddenRootsObj			<Integer oop>
	invalidObjStackPage		<Integer oop|nil>
	lastFreeChunk				<Integer oop|nil>
	lastHash					<Integer>
	lowSpaceThreshold		<Integer address>
	marking					<Boolean>
	markStack					<Integer objStack oop>
	memory					<Bitmap|LittleEndianBitmap>
	needGCFlag				<Boolean>
	newSpaceLimit				<Integer address>
	newSpaceStart				<Integer address>
	nilObj						<Integer oop>
	numClassTablePages		<Integer>
	objStackInvalidBecause	<String|nil>
	oldSpaceStart				<Integer address>
	pastSpaceStart				<Integer address>
	remapBuffer				<CArrayAccessor on: (Array new: RemapBufferSize)>
	remapBufferCount			<Integer>
	scavengeInProgress		<Boolean>
	scavengeThreshold		<Integer address>
	scavenger					<SourGenerationScavenger>
	segmentManager			<SpurSegmentManager>
	signalLowSpace			<Boolean>
	shrinkThreshold			<Integer>
	specialObjectsOop			<Integer oop>
	statCoalesces				<Integer>
	statCompactPassCount		<Integer>
	statFGCDeltaUsecs			<Integer>
	statFullGCUsecs			<Integer>
	statFullGCs					<Integer>
	statGCEndUsecs			<Integer>
	statGrowMemory			<Integer>
	statIGCDeltaUsecs			<Integer>
	statIncrGCUsecs			<Integer>
	statIncrGCs					<Integer>
	statMarkCount				<Integer>
	statRootTableCount		<Integer>
	statRootTableOverflows	<Integer>
	statSGCDeltaUsecs		<Integer>
	statScavengeGCUsecs		<Integer>
	statScavenges				<Integer>
	statShrinkMemory			<Integer>
	statSpecialMarkCount		<Integer>
	statSurvivorCount			<Integer>
	totalFreeOldSpace			<Integer>
	trueObj						<Integer oop>
	unscannedEphemerons		<SpurContiguousObjStack>
	weaklingStack				<Integer objStack oop>

becomeEffectsFlags
	- a set of flags to limit the work done during become; one of BecameCompiledMethodFlag, BecamePointerObjectFlag
	
checkForLeaks
	- a set of flags determining when to run leak checks on the heap's contents

classTableBitmap
	- a bitmap used to mark used classTable entries (i.e. marks classIndices, not class objects), used to reclaim unused entries.

classTableFirstPage
	- the first page of the class table which contains all classes known to the VM at known indices

classTableIndex
	- the last known used index in the class table, used to limit the search for empty slots

coInterpreter
	- the VM interpreter using this heap

edenBytes
	- a variable holding the size of eden at start up only

endOfMemory
	- the address past the last oldSpace segment

ephemeronQueue
	- the oopStack holding triggered ephemerons

extraRootCount
	- the count of extra roots

extraRoots
	- an array of pointers to variables holding oops that need updating.  used by plugins to update objects they hold on to.

falseObj
	- the oop of the false object; must be the second object in oldSpace

firstFreeChunk
	- the free chunk at the lowest address discovered during global gc's sweep through the heap.  used in compaction.

freeLists
	- an array of list heads of free chunks of each size (in allocationUnits).  the 0'th element
	  is the head of a tree of free chunks of size > 63 slots in 64-bits or 31 slots in 32-bits.
	  freeLists is the firstIndexableField of the fourth object in oldSpace.

freeListsMask
	- a bitmap of flags with a 1 set whereever the freeLists has a non-empty entry, used to limit the search for free chunks

freeOldSpaceStart
	- the last used address in oldSpace.  The space between freeOldSpaceStart and endOfMemory can be used for oldSpace allocations.
	  Given freeLists this probably isn't useful and shoud be discarded in favouf of endOfMemory.

freeStart
	- the last used address in eden.  this is where new objects are allocated if there is room in eden.

gcStartUsecs
	- the time in microseconds of the start of the most recent gc, used to compute the duration of a gc.

growHeadroom
	- the minimum ammount of space to grow memory by when a grow is required.

heapMap
	- a bitmap used to check for leaks. a bit is set in the map at each object's header.  every pointer in the heap should point to the header of an object

hiddenRootsObj
	- the root page of the class table and some other toos (e.g. the ephemeron queue). its first
	  numClassTablePages elements are pages containing classes. Remaining slots hold other
	  roots the VM needs.  Must be the fifth object in oldSpace.

invalidObjStackPage
	- the offending objStack page, if isValidObjStack: failed, or nil. This is for debugging.

lastFreeChunk
	- the free chunk at the highest address discovered during global gc's sweep through the heap.  used in compaction.

lastHash
	- the last object hash value.  a pseudo-random number generator.

lowSpaceThreshold
	- the ammount of free memory below which the low space condition should be signalled.

marking
	- a flag set and cleared in markAccessibleObjects to allow ensureRoomOnObjStackAtIndex: to know whether to mark a new obj stack page or not.

markStack
	- the objStack that houses the mark stack.

memory
	- in the Simulator this is the single oldSpace segment that contains the codeZone, newSpace and oldSpace.  In C it is effectively the base address of used memory.

needGCFlag
	- a boolean flag set if a scavenge is needed

newSpaceStart
	- the first address in newSpace (the start address of the first of the two survivor spaces, past and future space)

newSpaceLimit
	- the last address in newSpace (the last address in eden)

nilObj
	- the oop of the nil object; must be the first object in oldSpace

numClassTablePages
	- the number of used pages in the classTable

objStackInvalidBecause
	- a string identifying the reason isValidObjStack: failed, or nil.  This is for debugging.

oldSpaceStart
	- the start of oldSpace, which happens to be nilObj.

pastSpaceStart
	- the address past the last object in pastSpace, used to enumerate objects in newSpace.

remapBuffer
	- an Array of objects used to implement pushRemappableOop: et al for compatibility with ObjectMemory.
	  Its functionality isnt needed because Spur will never GC during allocation.  But it muts be present and
	  correct, otherwise many primitives that use pushRemappableOop: et al would have to be rewritten.

remapBufferCount
	- the index of the last used entry in remampBuffer

scavengeInProgress
	- flag indicating what it says it does

scavengeThreshold
	- a tidemark in eden.  needGCFlag is set if a newSpace allocation pushes freeStart past scavengeThreshold

scavenger
	- the generation scavenger that collects objects in newSpace

segmentManager
	- the object that manages oldSpace segments.  Segments are largely invisible to the memory manager because
	  the gaps between segments are hidden by bridge objects.

shrinkThreshold
	- the amount of free oldSpace above which the manager should attempt to give memory back to the OS.

signalLowSpace
	- a boolean flag set if the lowSpaceSemaphore should be signalled

specialObjectsOop
	- the oop of the specialObjectsArray object

statFGCDeltaUsecs statFullGCUsecs statFullGCs statGCEndUsecs statGrowMemory statIGCDeltaUsecs statIncrGCUsecs statIncrGCs statMarkCount statMkFwdCount statRootTableCount statRootTableOverflows statSGCDeltaUsecs statScavengeGCUsecs statScavenges statShrinkMemory statSpecialMarkCount statSurvivorCount statSweepCount
	- various statistics

totalFreeOldSpace
	- the total free space on the free lists
	
trueObj
	- the oop of the false object; must be the third object in oldSpace

unscannedEphemerons
	- the set of ephemerons yet to be scanned.  used for identifying firable ephemerons during gc.

weaklingStack
	- the set of weak collections that must be scanned later on in gc to nil their collected referents.



Invariants (far from an exhaustive list; I'm adding to this as they arise; please prompt me to add undocumented ones):

On image load no object contains a forwarding pointer, and the image contains no forwarders. True because
a) the SpurBootstrap eliminates forwarders before saving its transformed image
b) snapshot does a fullGC which will follow forwarding pointers.
This is checked with an assert in swizzleFieldsOfObject:/lastPointerOfWhileSwizzling:.

classTableIndex ranges from classTablePageSize to classTableMask, since the first page is reserved for system classes, and the VM won't assign classes there-in.

Design
The design objectives for the Spur memory manager are

- efficient object representation a la Eliot Miranda's VisualWorks 64-bit object representation that uses a 64-bit header, eliminating direct class references so that all objects refer to their classes indirectly.  Instead the header contains a constant class index, in a field smaller than a full pointer, These class indices are used in inline and first-level method caches, hence they do not have to be updated on GC (although they do have to be traced to be able to GC classes).  Classes are held in a sparse strong table.  The class table needs only to be indexed by an instance's class index in class hierarchy search, in the class primitive, and in tracing live objects in the heap.  The additional header space is allocated to a much expanded identity hash field, reducing hash efficiency problems in identity collections due to the extremely small (11 bit) hash field in the old Squeak GC.  The identity hash field is also a key element of the class index scheme.  A class's identity hash is its index into the class table, so to create an instance of a class one merely copies its identity hash into the class index field of the new instance.  This implies that when classes gain their identity hash they are entered into the class table and their identity hash is that of a previously unused index in the table.  It also implies that there is a maximum number of classes in the table.  The classIndex field could be as narrow as 16 bits (for efficient access); at least for a few years 64k classes should be enough.  But currently we make it the same as the identityHash field, 22 bits, or 4M values.  A class is entered into the class table in the following operations:
	behaviorHash
	adoptInstance
	instantiate
	become  (i.e. if an old class becomes a new class)
		if target class field's = to original's id hash
		   and replacement's id hash is zero
			enter replacement in class table
behaviorHash is a special version of identityHash that must be implemented in the image by any object that can function as a class (i.e. Behavior).

- more immediate classes.  An immediate Character class would speed up String accessing, especially for WideString, since no instatiation needs to be done on at:put: and no dereference need be done on at:.  In a 32-bit system tag checking is complex since it is thought important to retain 31-bit SmallIntegers.  Hence, as in current Squeak, the least significant bit set implies a SmallInteger, but Characters would likely have a tag pattern of xxx10.  Hence masking with 11 results in two values for SmallInteger, xxx01 and xxx11 (for details see In-line cache probe for immediates below).  30-bit characters are more than adequate for Unicode.  In a 64-bit system we can use the full three bits and usefully implement an immediate Float.  As in VisualWorks a functional representation takes three bits away from the exponent.  Rotating to put the sign bit in the least significant non-tag bit makes expanding and contracting the 8-bit exponent to the 11-bit IEEE double exponent easy and makes comparing negative and positive zero easier (an immediate Float is zero if its unsigned 64-bits are < 16).  So the representation looks like
	| 8 bit exponent | 52 bit mantissa | sign bit | 3 tag bits |
For details see "60-bit immediate Floats" below.


- efficient scavenging.  The current Squeak GC uses a slow pointer-reversal collector that writes every field in live objects three times in each collection, twice in the pointer-reversing heap traversal to mark live objects and once to update the pointer to its new location.  A scavenger writes every field of live data twice in each collection, once as it does a block copy of the object when copying to to space, once as it traverses the live pointers in the to space objects.  Of course the block copy is a relatively cheap write.

- lazy become.  The JIT's use of inline cacheing provides a cheap way of avoiding scanning the heap as part of a become (which is the simple approach to implementing become in a system with direct pointers).  A becomeForward: on a (set of) non-zero-sized object(s) turns the object into a "corpse" or "forwarding object" whose first (non-header) word/slot is replaced by a pointer to the target of the becomeForward:.  The corpse's class index is set to one that identifies corpses (let's say classIndex 1), and, because it is a special, hidden class index, will always fail an inline cache test.  The inline cache failure code is then responsible for following the forwarding pointer chain (these are Iliffe vectors :) ) and resolving to the actual target.  (In the interpreter there needs to be a similar check when probing the method cache).   It has yet to be determined exactly how this is done (e.g. change the receiver register and/or stack contents and retry the send, perhaps scanning the current activation).  See become read barrier below on how we deal with becomes on objects with named inst vars.  We insist that objects are at least 16 bytes in size (see 8-byte alignment below) so that there will always be space for a forwarding pointer.  Since none of the immediate classes can have non-immediate instances and since we allocate the immediate class indices corresponding to their tag pattern (SmallInteger = 1 & 3, Character = 2, SmallFloat = 5?) we can use all the class indices from 0 to 7 for special uses, 0 = free, and e.g. 1 = isForwarded.  In general what's going on here is the implemention of a partial read barrier. Certain operations require a read barrier to ensure access of the target of the forwarding corpse, not the corpse itself.  Read barriers stink (have poor performance), so we must restrict the read barrier to as few places as possible.  See become read barrier below.  See http://www.mirandabanda.org/cogblog/2013/09/13/lazy-become-and-a-partial-read-barrier/ & http://www.mirandabanda.org/cogblog/2014/02/08/primitives-and-the-partial-read-barrier/.

- pinning.  To support a robust and easy-to-use FFI the memory manager must support temporary pinning where individual objects can be prevented from being moved by the GC for as long as required, either by being one of an in-progress FFI call's arguments, or by having pinning asserted by a primitive (allowing objects to be passed to external code that retains a reference to the object after returning).  Pinning probably implies a per-object "is-pinned" bit in the object header.  Pinning will be done via lazy become; i..e an object in new space will be becommed into a pinned object in old space.  We will only support pinning in old space.

- efficient old space collection.  An incremental collector (a la Dijkstra's three colour algorithm) collects old space, e.g. via an amount of tracing being hung off scavenges and/or old space allocations at an adaptive rate that keeps full garbage collections to a minimum.  It may also be possible to provide cheap compaction by using lazy become: and best-fit (see free space/free list below).

- 8-byte alignment.  It is advantageous for the FFI, for floating-point access, for object movement and for 32/64-bit compatibility to keep object sizes in units of 8 bytes.  For the FFI, 8-byte alignment means passing objects to code that expects that requirement (such as modern x86 numeric processing instructions).  This implies that
	- the starts of all spaces are aligned on 8-byte boundaries
	- object allocation rounds up the requested size to a multiple of 8 bytes
	- the overflow size field is also 8 bytes
We shall probably keep the minimum object size at 16 bytes so that there is always room for a forwarding pointer.  But this implies either that we round object lengths up to units of 16 bytes (current choice) or that we need to implement an 8-byte filler to fill holes between objects > 16 bytes whose length mod 16 bytes is 8 bytes and following pinned objects.  We can do this using a special class index, e.g. 1, so that the method that answers the size of an object looks like, e.g.
	chunkSizeOf: oop
		<var: #oop type: #'object *'>
		^object classIndex = 1
			ifTrue: [BaseHeaderSize]
			ifFalse: [BaseHeaderSize
				  + (object slotSize = OverflowSlotSize
						ifTrue: [OverflowSizeBytes]
						ifFalse: [0])
				  + (object slotSize * BytesPerSlot)]

	chunkStartOf: oop
		<var: #oop type: #'object *'>
		^(self cCoerceSimple: oop to: #'char *')
			- ((object classIndex = 1
			    or: [object slotSize ~= OverflowSlotSize])
					ifTrue: [0]
					ifFalse: [OverflowSizeBytes])

Note that the size field of an object (its slot size) reflects the logical size of the object e.g. 0-element array => 0 slot size, 1-element array => 1 slot size). The memory manager rounds up the slot size as appropriate, e.g. (self roundUp: (self slotSizeOf: obj) * 4 to: 8) min: 8.

Heap growth and shrinkage will be handled by allocating and deallocating heap segments from/to the OS via e.g. memory-mapping.  This technique allows space to be released back to the OS by unmapping empty segments.  See "Segmented Old Space" below).

The basic approach is to use a fixed size new space and a growable old space.  The new space is a classic three-space nursery a la Ungar's Generation Scavenging, a large eden for new objects and two smaller survivor spaces that exchange roles on each collection, one being the to space to which surviving objects are copied, the other being the from space of the survivors of the previous collection, i.e. the previous to space.  (This basic algorithm is extended to handle weak arrays and ephemerons).

To provide apparent pinning in new space we rely on lazy become.  Since most pinned objects will be byte data and these do not require stack zone activation scanning, the overhead is simply an old space allocation and corpsing.

To provide pinning in old space, large objects are implicitly pinned (because it is expensive to move large objects and, because they are both large and relatively rare, they contribute little to overall fragmentation - as in aggregates, small objects can be used to fill-in the spaces between karge objects).  Hence, objects above a particular size are automatically allocated in old space, rather than new space.  Small objects are pinned as per objects in new space, by asserting the pin bit, which will be set automaticaly when allocating a large object.  As a last resort, or by programmer control (the fullGC primitive) old space is collected via mark-sweep (mark-compact) and so the mark phase must build the list of pinned objects around which the sweep/compact phase must carefully step.

Free space in old space is organized by a number of free lists and a free tree .  There are 32 or 64 free lists, depending on word size, indices 1 through wordSize - 1 holding blocks of space of the index * allocationUnit, index 0 holding a semi-balanced ordered tree of free blocks, each node being the head of the list of free blocks of that size.  At the start of the mark phase the free list is thrown away and the sweep phase coalesces free space and steps over pinned objects as it proceeds.  We can reuse the forwarding pointer compaction scheme used in the old collector.  Incremental collections merely move unmarked objects to the free lists (as well as nilling weak pointers in weak arrays and scheduling them for finalization).  The occupancy of the free lists is represented by a bitmap in an integer so that an allocation of size wordSize - 1 or less can know whether there exists a free chunk of that size, but more importantly can know whether a free chunk larger than it exists in the fixed size free lists without having to search all larger free list heads.

Incremental Old Space Collection
The incremental collector (a la Dijkstra's three colour algorithm) collects old space via an amount of tracing being hung off scavenges and/or old space allocations at an adaptive rate that keeps full garbage collections to a minimum.  [N.B. Not sure how to do this yet.  The incremental collector needs to complete a pass often enough to reclaim objects, but infrequent enough not to waste time.  So some form of feedback should work.  In VisualWorks tracing is broken into quanta or work where image-level code determines the size of a quantum based on how fast the machine is, and how big the heap is.  This code could easily live in the VM, controllable through vmParameterAt:put:.  An alternative would be to use the heartbeat to bound quanta by time.  But in any case some amount of incremental collection would be done on old space allocation and scavenging, the ammount being chosen to keep pause times acceptably short, and at a rate to reclaim old space before a full GC is required, i.e. at a rate proportional to the growth in old space]. The incemental collector is a state machine, being either marking, nilling weak pointers, or freeing.  If nilling weak pointers is not done atomically then there must be a read barrier in weak array at: so that reading from an old space weak array that is holding stale un-nilled references to unmarked objects.  Tricks such as including the weak bit in bounds calculations can make this cheap for non-weak arrays.  Alternatively nilling weak pointers can be made an atomic part of incremental collection, which can be made cheaper by maintaining the set of weak arrays (e.g. on a list).  Note that the incremental collector also follows (and eliminates) forwarding pointers as it scans.

The incremental collector implies a more complex write barrier.  Objects are of three colours, black, having been scanned, grey, being scanned, and white, unreached.  A mark stack holds the grey objects.   If the incremental collector is marking and an unmarked white object is stored into a black object then the stored object must become grey, being added to the mark stack.  So the wrte barrier is essentially
	target isYoung ifFalse:
		[newValue isYoung
			ifTrue: [target isInRememberedSet ifFalse:
					[target addToRememberedSet]] "target now refers to a young object; it is a root for scavenges"
			ifFalse:
				[(target isBlack
				  and: [igc marking
				  and: [newValue isWhite]]) ifTrue:
					[newValue beGrey]]] "add newValue to IGC's markStack for subsequent scanning"

The incremental collector does not detect already marked objects all of whose references have been overwritten by other stores (e.g. in the above if newValue overwrites the sole remaining reference to a marked object).  So the incremental collector only guarantees to collect all garbage created in cycle N at the end of cycle N + 1.  The cost is hence slightly worse memory density but the benefit, provided the IGC works hard enough, is the elimination of long pauses due to full garbage collections, which become actions of last resort or programmer desire.

Incremental Best-Fit Compaction
The free list also looks like it allows efficient incremental compaction.  Currently in the 32-bit implementation, but easily affordable in the 64-bit implementation, objects have at least two fields, the first one being a forwarding pointer, the second one rounding up to 8-byte object alignment.  On the free list the first field is used to link the list of free chunks of a given size.  The second field could be used to link free chunks in memory order.  And of course the last free chunk is the chunk before the last run of non-free objects.  We compact by

a) keeping each free list in memory order (including the lists of free chunks off each node in the large free chunk tree)
b) sorting the free chunks in memory order by merge sorting the free lists
c) climbing the free list in memory order.  For each free chunk in the free list search memory from the last free chunk to the end (and from the previous chunk to the next chunk, and so on) looking for a best-fit live object.  That object is then copied into the free chunk, and its corpse is turned into a forwarding pointer.  This works because the compaction does not slide objects, and hence no forwarding blocks are necessary and the algorithm can be made incremental. Various optimizations are possible, e.g. using a bitmap to record the sizes of the first few free chunks on the list when looking for best fits.  The assumptions being
a) the number fo objects on the free list is kept small because the IGC incrementally compacts, and so sorting and searching the list is not expensive
b) the incremental collector's following of forwarding pointers reclaims the corpses at the end of memory at a sufficient rate to keep the free list small
c) the rounding of objects to an 8-byte alignment improves the chances of finding a best fit.
Note that this incremental collection is easily amenable to leave pinned objects where they are; they are simply filtered out when looking for a best fit.

Segmented Old Space
A segmented oldSpace is useful.  It allows growing oldSpace incrementally, adding a segment at a time, and freeing empty segments.  But such a scheme is likely to introduces complexity in object enumeration, and compaction (enumeration would apear to require visiting each segment, compaction must be wthin a segment, etc). One idea that might fly to allow a segmented old space that appears to be a single contiguous spece is to use fake pinned objects to bridge the gaps between segments.  The last two words of each segment can be used to hold the header of a pinned object whose size is the distance to the next segment.  The pinned object's classIndex can be one of the puns so that it doesn't show up in allInstances; this can perhaps also indicate to the incremental collector that it is not to reclaim the object, etc.  However, free objects would need a large enough size field to stretch across large gaps in the address space.  The current design limits the overflow size field to a 32-bit slot count, which wouldn't be large enough in a 64-bit implementation.  The overflow size field is at most 7 bytes since the overflow size word also contains a maxed-out 8-bit slot count (for object parsing).  A byte can be stolen from e.g. the identityHash field to beef up the size to a full 64-bits.


Lazy become & the become read barrier (see http://www.mirandabanda.org/cogblog/2013/09/13/lazy-become-and-a-partial-read-barrier/ & http://www.mirandabanda.org/cogblog/2014/02/08/primitives-and-the-partial-read-barrier/).

As described earlier the basic idea behind lazy become is to use corpses (forwarding objects) that are followed lazily during GC and inline cache miss.  However, a lazy scheme would appear to require a read barrier to avoid accessing the coirpse and mak sure wel follow the forwarding pointer.  Without hardware support read barriers have poor performance, so we must restrict the read barrier as much as possible.  The main goal is to avoid having to scan all of the heap to fix up pointers, as is done with ObjectMemory.  We're happy to do some scanning of a small subset oif the heap, but become: cannot scale to large heaps if it must scan the entire heap.  Objects with named inst vars and CompiledMethods are accessed extensively by the interpreter and jitted code.  We must avoid as much checking of such accesses as possible; We judge an explicit read barrier on all accesses far too expensive.  The accesses the VM makes which notionally require a read barrier are:
- inst vars of thisContext, including stack contents (the receiver of a message and its arguments), which in Cog are the fields of the current stack frame, and the sender chain during (possibly non-local) return
- named inst vars of the receiver
- literals of the current method, in particular variable bindings (a.k.a. literal variables which are global associations), including the methodClass association.
- in primitives, the receiver and arguments, including possible sub-structure.
We have already discussed that we will catch an attempt to create a new activation on a forwarded object therough method lookup failing for forwarded objects.  This would occur when e.g. some object referenced by the receiver via its inst vars is pushed on the stack as a message receiver, or e.g. answered as the result of some primtiive which accesses object state such as primtive at:  So there is no need for a read barrier when accessing a new receiver or returning its state.  But there must presumably be a read barrier in primitives that inspect that sub-state.

However, we can easily avoid read barriers in direct literal access, and class hierarchy walking and message dictionary searching in message lookup.  Whenever the become operation becomes one or more pointer objects (and it can e.g. cheaply know if it has becommed a CompiledMethod) both the class table and the stack zone are scanned.  In the class table we can follow the forwarding pointers in all classes in the table, and we can follow their superclasses.  But we would like to avoid scanning classes many times.  Any superclass that has a non-zero hash must be in the table and will be encountered during the scan of the class table.  Any superclass with a zero hash can be entered into the table at a point subsequent to the current index and hence scanned.  The class scan can also scan method dictionary selectors and follow the methiod dictionary's array reference (so that dictionaries are valid for lookup) and scan the dictionary's method array iff a CompiledMethod was becommed. (Note that support for object-as-method implies an explicit read barrier in primitiveObjectAsMethod, which is a small overhead there-in).

Accessing possibly forwarded method literals is fine; these forwarding objects will be pushed on the stack and caught either by the message lookup trap or explicitly in primitives that access arguments.  However, push/store/pop literal variable cannot avoid an explicit check without requiring we scan all methods, which will be far too expensive.  To avoid a check on super send when accessing a method's method class association, we must check the method class associations of any method in the stack zone, and in the method of any context faulted into the stack zone on return.

We avoid a read barrier on access to receiver inst vars by scanning the stack zone and following pointers to the receiver.

Amd of course, all of the scavenger, the incremental scan-mark-compactor and the global garbage collector follow and eliminate forwarding pointers as part of their object graph traversals.

This means explicit read barriers in
- push/store/pop literal variable
- return (accessing the sender context, its inst vars, and the method class association of its method)
- primitives that inspect the class and/or state of their arguments, excepting immediates.  e.g. in at:put: (almost) no checks are required because the receiver will have been caught by the message send trap, the index is a SmallInteger and the argument is either an immediate Character (in String>>at:put:) or a possibly forwarded object stored into an array; i.e. the argument's state is inspected only if it is an immediate (the exception is 64-bit indexable and 32-bit indexable floats & bitmaps which could take LargeIntegers whose contents are copied into the relevant field).  But e.g. in beCursor extensive checks are required because the primitive inspects a couple of form instances, and a point that are sub-state of the Cursor object.

One approach would be an explicit call in the primitive, made convenient via providing something like ensureNoForwardingPointersIn: obj toDepth: n, which in beCursor's case would look like interpreter ensureNoForwardingPointersIn: cursorObj toDepth: 3 (the offset point of the mask form).
Another approach would be to put an explicit read barrier in store/fetchPointer:ofObject:[withValue:] et al, but provide an additional api (e.g. store/fetchPointer:ofNonForwardedObject:[withValue:] et al) and use it in the VM's internals.  The former approach is error-prone, but the latter approach is potentially ugly, touching nearly all of the core VM code.  It would appear that one of these two approaches must be chosen.

61-bit immediate Floats
Representation for immediate doubles, only used in the 64-bit implementation. Immediate doubles have the same 52 bit mantissa as IEEE double-precision  floating-point, but only have 8 bits of exponent.  So they occupy just less than the middle 1/8th of the double range.  They overlap the normal single-precision floats which also have 8 bit exponents, but exclude the single-precision denormals (exponent-127) and the single-precsion NaNs (exponent +127).  +/- zero is just a pair of values with both exponent and mantissa 0. 
So the non-zero immediate doubles range from 
        +/- 0x3800,0000,0000,0001 / 5.8774717541114d-39 
to      +/- 0x47ff,ffff,ffff,ffff / 6.8056473384188d+38 
The encoded tagged form has the sign bit moved to the least significant bit, which allows for faster encode/decode because offsetting the exponent can't overflow into the sign bit and because testing for +/- 0 is an unsigned compare for <= 0xf: 
    msb                                                                                        lsb 
    [8 exponent subset bits][52 mantissa bits ][1 sign bit][3 tag bits] 
So assuming the tag is 5, the tagged non-zero bit patterns are 
             0x0000,0000,0000,001[d/5] 
to           0xffff,ffff,ffff,fff[d/5] 
and +/- 0d is 0x0000,0000,0000,000[d/5] 
Encode/decode of non-zero values in machine code looks like: 
						msb                                              lsb 
Decode:				[8expsubset][52mantissa][1s][3tags] 
shift away tags:			[ 000 ][8expsubset][52mantissa][1s] 
add exponent offset:	[     11 exponent     ][52mantissa][1s] 
rot sign:				[1s][     11 exponent     ][52mantissa]

Encode:					[1s][     11 exponent     ][52mantissa] 
rot sign:				[     11 exponent     ][52mantissa][1s] 
sub exponent offset:	[ 000 ][8expsubset][52 mantissa][1s] 
shift:					[8expsubset][52 mantissa][1s][ 000 ] 
or/add tags:			[8expsubset][52mantissa][1s][3tags] 
but is slower in C because 
a) there is no rotate, and 
b) raw conversion between double and quadword must (at least in the source) move bits through memory ( quadword = *(q64 *)&doubleVariable). 


Heap Walking
In heap walking the memory manager needs to be able to detect the start of the next object.  This is complicated by the short and long header formats, short being for objects with 254 slots or less, long being for objects with 255 slots or more.  Since an object that has an overflow header must have 255 as its header slot count we can use this as the marker.  The overflow header word also has a numSlots field, set to 255.  The remainder of the overflow size field is used for the object's slot size, the least significant word in 32-bits (for 2^34 bytes, more than the address space), the remaining 56 bits in 64-bits (for 2^59 bytes, which we hope is big enough for bridge objects).  So if the word following an object contains 255 in its numSlots field, it must be the overflow size word of an object with a double header, and the word after that is the header, also with a saturated numSlots field.

Total Number of Classes and Instance-specific Behaviours
While the class index header field has advantages (saving significant header space, especially in 64-bits, providing a non-moving cache tag for inline caches, small constants for instantiating well-known classes instead of having to fetch them from a table such as the specialObjectsArray) it has the downside of limiting the number of classes.  For Smalltalk programs 2^20 to 2^24 classes is adequate for some time to come, but for prototype languages such as JavaScript this is clearly inadequate, and we woud like to support the ability to host prototype languages within Squeak. There is a solution in the form of "auto-instances", an idea of Claus Gittinger's.  The idea is to represent prototypes as behaviors that are instances of themselves.  In a classical Smalltalk system a Behavior is an object with the minimal amount of state to function as a class, and in Smalltalk-80 this state is the three instance variables of Behavior, superclass, methodDict and format, which are the only fields in a Behavior that are known to the virtual machine.  A prototype can therefore have its own behavior and inherit from other prototypes or classes, and have sub-prototypes derived from it if a) its first three instance variables are also superclass, methodDict, and format, and b) it is an instance of itself (one can create such objects in a normal Smalltalk system by creating an Array with the desired layout and using a change class primitive to change the class of the Array to itself).  The same effect can be achieved in a VM with class indexes by reserving one class index to indicate that the object is an instance of itself, hence not requiring the object be entered into the class table and in the code that derives the class of an object, requiring one simple test answering the object itself instead of indexing the class table.  There would probably need to be an auto-instantiation primitive that takes a behavior (or prototype) and an instance variable count and answers a new auto-instance with as many instance variables as the sum of the behavior (or prototype) and the instance variable count.  Using this scheme there can be as many auto-instances as available address space allows while retaining the benefits of class indices.

This scheme has obvious implications for the inline cache since all prototypes end up having the same inline cache tag.  Either the inline cache check checks for the auto-instance class tag and substitutes the receiver, or the cacheing machinery refuses to add the auto-instance class tag to any inline cache and failure path code checks for the special case.  Note that in V8 failing monomorphic sends are patched to open PICs (megamorphic sends); V8 does not use closed PICs due to the rationale that polymorphism is high in JavaScript.

Miscellanea
In-line cache probe for immediates
We would like to keep 31-bit SmallIntegers for the 32-bit system.  Lots of code could be impacted by a change to 30-bit SmallIntegers.  If so, then 
	isImmediate: oop	^(oop bitAnd: 3) ~= 0
	isSmallInteger: oop	^(oop bitAnd: 1) ~= 0
	isCharacter: oop	^(oop bitAnd: 2) = 2
If the in-line cache contains 0 for Characters then the in-line cache code (in x86 machine code) reads as follows, for a branch-free common-case:
	Limm:
		andl $0x1, %eax
		j Lcmp
	Lentry:
		movl %edx, %eax
		andl $0x3, %eax
		jnz Limm
		movl 0(%edx), %eax
		andl $0x3fffff, %eax
	Lcmp:
		cmpl %ecx, %eax
		jnz Lmiss

64-Bit sizes:
We extend the original Squeak 4-bit format field to 5 bits, providing space for 3 odd bits for byte objects (2 for short objects & 1 for 32-bit long objects).  Object sizes are slots, and byte (and short and 32-bit) lengths are computed by subtracting the odd bits from the shifted slot length.  Keeping the format field saves bits because it subsumes the isWeak,isEphemeron,isPointer bits that would be necessary otherwise.  The format field is organized as follows:
	 0 = 0 sized objects (UndefinedObject True False et al)
	 1 = non-indexable objects with inst vars (Point et al)
	 2 = indexable objects with no inst vars (Array et al)
	 3 = indexable objects with inst vars (MethodContext AdditionalMethodState et al)
	 4 = weak indexable objects with inst vars (WeakArray et al)
	 5 = weak non-indexable objects with inst vars (ephemerons) (Ephemeron)
	 6 unused, reserved for exotic pointer objects?  e.g. contexts?
	 7 Forwarded Object, 1st field is pointer, rest of fields are ignored
	 8 unused, reserved for exotic non-pointer objects?
	 9 64-bit indexable
	10 - 11 32-bit indexable	(11 unused in 32 bits)
	12 - 15 16-bit indexable	(14 & 15 unused in 32-bits)
	16 - 23 byte indexable		(20-23 unused in 32-bits)
	24 - 31 compiled method	(28-21 unused in 32-bits)


One obvious optimization to images is to add image (de)compression to image loading and snapshot.  The image header remains unchanged but its contents could be compressed, compressing either on snapshot, if requested, or off-line via a special-purpose tool.

Issues:
Are class indices in inline caches strong references to classes or weak references?
If strong then they must be scanned during GC and the methodZone must be flushed on fullGC to reclaim all classes (this looks to be a bug in the V3 Cogit).
If weak then when the class table loses references, PICs containing freed classes must be freed and then sends to freed PICs or containing freed clases must be unlinked.
The second approach is faster; the common case is scanning the class table, the uncommon case is freeing classes.  The second approach is better for machine code; in-line caches do not prevent reclamation of classes.  However, the former is better for the scavenger which as a result doesn't have to scan the classes of objects.  The system scavenges much more frequently than it reclaims classes and the number of cog methods to be scanned during scavenge is small.  So I think a strong class table is better after all.  Indeed we use a strong class table with old pages.  So classes are only GCed by the incremental and global GCs, never by the scavenger.