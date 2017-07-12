image segment in/out
storeImageSegmentInto: segmentWordArrayArg outPointers: outPointerArrayArg roots: arrayOfRootsArg
	"This primitive is called from Squeak as...
		<imageSegment> storeSegmentFor: arrayOfRoots into: aWordArray outPointers: anArray.

	 This primitive will store a binary image segment (in the same format as objects in the heap) of the
	 set of objects in arrayOfObjects.  All pointers from within the set to objects outside the set will be
	 copied into the array of outPointers.  In their place in the image segment will be an oop equal to the
	 offset in the outPointer array (the first would be 8), but with the high bit set.

	 Since Spur has a class table the load primitive must insert classes that have instances into the
	 class table.  This primitive marks such classes using the isRemembered bit, which isn't meaningful
	 as a remembered bit in the segment.

	 The primitive expects the segmentWordArray and outPointerArray to be more than adequately long.
	 In this case it returns normally, and truncates the two arrays to exactly the right size.

	 The primitive can fail for the following reasons with the specified failure codes:
		PrimErrGenericError:		the segmentWordArray is too small for the version stamp
		PrimErrWritePastObject:	the segmentWordArray is too small to contain the reachable objects
		PrimErrBadIndex:			the outPointerArray is too small
		PrimErrNoMemory:			additional allocations failed
		PrimErrLimitExceeded:		there is no room in the hash field to store out pointer indices or class references."
	<inline: false>
	| segmentWordArray outPointerArray arrayOfRoots
	  arrayOfObjects savedFirstFields savedOutHashes segStart segAddr endSeg outIndex numClassesInSegment |
	<var: 'segAddr' type: #usqInt>
	((self isObjImmutable: segmentWordArrayArg)
	 or: [self isObjImmutable: outPointerArrayArg]) ifTrue:
		[^PrimErrNoModification].
	"Since segmentWordArrayArg & outPointerArrayArg may get shortened, they can't be pinned."
	((self isPinned: segmentWordArrayArg)
	 or: [self isPinned: outPointerArrayArg]) ifTrue:
		[^PrimErrObjectIsPinned].
	(self numSlotsOf: outPointerArrayArg) > self maxIdentityHash ifTrue:
		[^PrimErrLimitExceeded].

	self runLeakCheckerFor: GCModeImageSegment.

	"First scavenge to collect any new space garbage that refers to the graph."
	self scavengingGC.
	segmentWordArray := self updatePostScavenge: segmentWordArrayArg.
	outPointerArray := self updatePostScavenge: outPointerArrayArg.
	arrayOfRoots := self updatePostScavenge: arrayOfRootsArg.
	self deny: (self forwardersIn: outPointerArray).
	self deny: (self forwardersIn: arrayOfRoots).
	
	"Now compute the transitive closure, collecting the sequence of objects to be stored in the arrayOfObjects array.
	 Included in arrayOfObjects are the arrayOfRoots and all its contents.  All objects have been unmarked."
	arrayOfObjects := self objectsReachableFromRoots: arrayOfRoots.
	arrayOfObjects ifNil:
		[^PrimErrNoMemory].

	self assert: self allObjectsUnmarked. "work to be done when the incremental GC is written"
	self deny: (self forwardersIn: arrayOfObjects).

	"Both to expand the max size of segment and to reduce the length of the
	 load-time pass that adds classes to the class table, move classes to the
	 front of arrayOfObjects, leaving the root array as the first element."
	numClassesInSegment := self moveClassesForwardsIn: arrayOfObjects.

	"The scheme is to copy the objects into segmentWordArray, and then map the oops in segmentWordArray.
	 Therefore the primitive needs to both map efficiently originals to copies in segmentWordArray and
	 be able to undo any side-effects if the primitive fails because either segmentWordArray or outPointerArray
	 is too small.  The mapping is done by having the objects to be stored in arrayOfObjects refer to their mapped
	 locations through their first field, just like a forwarding pointer, but without becoming a forwarder, saving their
	 first field in savedFirstFields, and the objects in outPointerArray pointing to their locations in the outPointerArray
	 through their identityHashes, saved in savedOutHashes.
	 Since arrayOfObjects and its savedFirstFields, and outPointerArray and its saved hashes, can be enumerated
	 side-by-side, the hashes can be restored to the originals.  So the first field of the heap object corresponding to
	 an object in arrayOfObjects is set to its location in segmentWordArray, and the hash of an object in outPointerArray
	 is set to its index in outPointerArray plus the top hash bit.  Classes in arrayOfObjects have their marked bit set.
	 Oops in objects in segmentWordArray are therefore mapped by accessing the original oop, and following its first
	 field. Class indices in segmentWordArray are mapped by fetching the original class, and testing its marked bit.
	 If marked, the first field is followed to access the class copy in the segment.  Out pointers (objects and classes,
	 which are unmarked), the object's identityHash is set (eek!!) to its index in the outPointerArray. So savedOutHashes
	 parallels the outPointerArray. The saved hash array is initialized with an out-of-range hash value so that the first
	 unused entry can be identified."

	savedFirstFields := self allocateSlots: (self numSlotsOf: arrayOfObjects)
							format: self wordIndexableFormat
							classIndex: self wordSizeClassIndexPun.
	savedOutHashes := self allocateSlots: (self numSlotsForBytes: (self numSlotsOf: outPointerArray) * 4)
							format: self firstLongFormat
							classIndex: self thirtyTwoBitLongsClassIndexPun.
	(savedFirstFields isNil or: [savedOutHashes isNil]) ifTrue:
		[self freeObject: arrayOfObjects.
		 ^PrimErrNoMemory].

	self fillObj: savedFirstFields numSlots: (self numSlotsOf: savedFirstFields) with: 0.
	self fillObj: savedOutHashes numSlots: (self numSlotsOf: savedOutHashes) with: self savedOutHashFillValue.

	segAddr := segmentWordArray + self baseHeaderSize.
	endSeg := self addressAfter: segmentWordArray.

	"Write a version number for byte order and version check."
	segAddr >= endSeg ifTrue: [^PrimErrGenericFailure].
	self long32At: segAddr put: self imageSegmentVersion.
	self long32At: segAddr + 4 put: self imageSegmentVersion.
	segStart := segAddr := segAddr + self allocationUnit.

	"Copy all reachable objects to the segment, setting the marked bit for all objects (clones) in the segment,
	 and the remembered bit for all classes (clones) in the segment."
	0 to: (self numSlotsOf: arrayOfObjects) - 1 do:
		[:i| | newSegAddrOrError objOop |
		"Check that classes in the segment are addressible.  Since the top bit of the hash field is used to tag
		 classes external to the segment, the segment offset must not inadvertently set this bit.  This limit still
		 allows for a million or more classes."
		(i = numClassesInSegment
		 and: [segAddr - segStart / self allocationUnit + self lastClassIndexPun >= TopHashBit]) ifTrue:
			[^self return: PrimErrLimitExceeded
					restoringObjectsIn: arrayOfObjects upTo: i savedFirstFields: savedFirstFields].
		objOop := self fetchPointer: i ofObject: arrayOfObjects.
		self deny: ((self isImmediate: objOop) or: [self isForwarded: objOop]).
		newSegAddrOrError := self copyObj: objOop
									toAddr: segAddr
									startAt: segStart 
									stopAt: endSeg
									savedFirstFields: savedFirstFields
									index: i.
		(self oop: newSegAddrOrError isLessThan: segStart) ifTrue:
			[^self return: newSegAddrOrError
					restoringObjectsIn: arrayOfObjects upTo: i savedFirstFields: savedFirstFields].
		 segAddr := newSegAddrOrError].

	"Check that it can be safely shortened."
	(endSeg ~= segAddr
	 and: [endSeg - segAddr < (self baseHeaderSize + self bytesPerOop)]) ifTrue:
		[^self return: PrimErrWritePastObject
				restoringObjectsIn: arrayOfObjects upTo: -1 savedFirstFields: savedFirstFields].

	"Now scan, adding out pointers to the outPointersArray; all objects in arrayOfObjects
	 have their first field pointing to the corresponding copy in segmentWordArray."
	(outIndex := self mapOopsFrom: segStart
					to: segAddr
					outPointers: outPointerArray
					outHashes: savedOutHashes) < 0 ifTrue: "no room in outPointers; fail"
		[^self return: PrimErrBadIndex
				restoringObjectsIn: arrayOfObjects savedFirstFields: savedFirstFields
				and: outPointerArray savedHashes: savedOutHashes].

	"We're done.  Shorten the results, restore hashes and return."
	self shorten: segmentWordArray toIndexableSize: segAddr - (segmentWordArray + self baseHeaderSize) / 4.
	self shorten: outPointerArray toIndexableSize: outIndex.
	^self return: PrimNoErr
		restoringObjectsIn: arrayOfObjects savedFirstFields: savedFirstFields
		and: outPointerArray savedHashes: savedOutHashes