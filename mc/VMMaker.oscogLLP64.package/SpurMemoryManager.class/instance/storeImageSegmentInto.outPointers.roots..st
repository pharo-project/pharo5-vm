image segment in/out
storeImageSegmentInto: segmentWordArray outPointers: outPointerArray roots: arrayOfRoots
	"This primitive is called from Squeak as...
		<imageSegment> storeSegmentFor: arrayOfRoots into: aWordArray outPointers: anArray.

	 This primitive will store a binary image segment (in the same format as objercts in the heap) of the
	 set of objects in arrayOfObjects.  All pointers from within the set to objects outside the set will be
	 copied into the array of outPointers.  In their place in the image segment will be an oop equal to the
	 offset in the outPointer array (the first would be 4). but with the high bit set.

	 Since Spur has a class table the load primitive must insert classes that have instances in the class
	 table.  This primitive marks such classes using the isRemembered bit, which isn't meaningful as a
	 remembered bit in the segment.

	 The primitive expects the segmentWordArray and outPointerArray to be more than adequately long.
	 In this case it returns normally, and truncates the two arrays to exactly the right size.

	 The primitive can fail for the following reasons with the specified failure codes:
		PrimErrWritePastObject:	the segmentWordArray is too small
		PrimErrBadIndex:			the outPointerArray is too small
		PrimErrNoMemory:			additional allocations failed
		PrimErrLimitExceeded:		there is no room in the hash field to store object oops."
	<inline: false>
	| arrayOfObjects savedInHashes savedOutHashes fillValue segStart segAddr endSeg outIndex |

	self runLeakCheckerFor: GCModeImageSegment.

	"First compute the transitive closure, collecting the sequence of objects to be stored in the arrayOfObjects array."
	arrayOfObjects := self objectsReachableFromRoots: arrayOfRoots.
	arrayOfObjects ifNil:
		[^PrimErrNoMemory].

	self assert: self allObjectsUnmarked. "work to be done when the incremental GC is written"

	"The scheme is to copy the objects into segmentWordArray, and then map the oops in sementWordArray.
	 Therefore the primitive needs to both map efficiently originals to copies in segmentWordArray and
	 be able to undo any side-effects if the primitive fails because either sementWordArray or outPointerArray
	 is too small.  The mapping is done by having the originals (either the objects in arrayOfObjects or the
	 objects in outPointerArray) refer to their mapped locations through their identityHash, and saving their
	 identityHashes in two ByteArrays, one that mirrors arrayOfObjects, and one that mirrors outPointerArray.
	 Since arrayOfObjects and its saved hashes, and outPointerArray and its saved hashes, can be enumerated
	 side-by-side, the hashes can be restored to the originals.  So the hash of an object in arrayOfObjects
	 is set to its offset in segmentWordArray / self allocationUnit, and the hash of an object in outPointerArray
	 is set to its index in outPointerArray plus the top hash bit.  Oops in segmentWordArray are therefore
	 mapped by accessing the original oop's identityHash, testing the bottom bit to distinguish between internal
	 and external oops.  The saved hash arrays are initialized with an out-of-range hash value so that the first
	 unused entry can be identified."

	savedInHashes := self allocateSlots: (self numSlotsForBytes: (self numSlotsOf: arrayOfObjects) * 4)
							format: self firstLongFormat
							classIndex: self thirtyTwoBitLongsClassIndexPun.
	savedOutHashes := self allocateSlots: (self numSlotsForBytes: (self numSlotsOf: outPointerArray) * 4)
							format: self firstLongFormat
							classIndex: self thirtyTwoBitLongsClassIndexPun.
	(savedInHashes isNil or: [savedOutHashes isNil]) ifTrue:
		[self freeObject: arrayOfObjects.
		 ^PrimErrNoMemory].

	fillValue := self wordSize = 4 ifTrue: [self maxIdentityHash + 1] ifFalse: [self maxIdentityHash + 1 << 32 + (self maxIdentityHash + 1)].
	self fillObj: savedInHashes numSlots: (self numSlotsOf: savedInHashes) with: fillValue.
	self fillObj: savedOutHashes numSlots: (self numSlotsOf: savedOutHashes) with: fillValue.

	"Both to expand the max size of segment and to reduce the length of the
	 load-time pass that adds classes to the class table, move classes to the
	 front of arrayOfObjects, leaving the root array as the first element."
	self moveClassesForwardsIn: arrayOfObjects.

	segAddr := segmentWordArray + self baseHeaderSize.
	endSeg := self addressAfter: segmentWordArray.

	"Write a version number for byte order and version check."
	segAddr >= endSeg ifTrue: [^PrimErrGenericFailure].
	self long32At: segAddr put: self imageSegmentVersion.
	self long32At: segAddr + 4 put: self imageSegmentVersion.
	segStart := segAddr := segAddr + self allocationUnit.

	"Copy all reachable objects to the segment."
	0 to: (self numSlotsOf: arrayOfObjects) - 1 do:
		[:i| | newSegAddrOrError objOop |
		objOop := self fetchPointer: i ofObject: arrayOfObjects.
		self deny: ((self isImmediate: objOop) or: [self isForwarded: objOop]).
		self storeLong32: i ofObject: savedInHashes withValue: (self rawHashBitsOf: objOop).
		newSegAddrOrError := self copyObj: objOop toAddr: segAddr startAt: segStart stopAt: endSeg.
		newSegAddrOrError < segStart ifTrue:
			[^self return: newSegAddrOrError
					restoringObjectsIn: arrayOfObjects savedHashes: savedInHashes
					and: outPointerArray savedHashes: savedOutHashes].
		 segAddr := newSegAddrOrError].

	"Check that it can be safely shortened."
	(endSeg ~= segAddr
	 and: [endSeg - segAddr < (self baseHeaderSize + self bytesPerOop)]) ifTrue:
		[^self return: PrimErrWritePastObject
				restoringObjectsIn: arrayOfObjects savedHashes: savedInHashes
				and: outPointerArray savedHashes: savedOutHashes].

	"Now scan, adding out pointers to the outPointersArray; all objects in arrayOfObjects
	 have their hashes set to point to their copies in segmentWordArray."
	(outIndex := self mapOopsFrom: segStart
					to: segAddr
					outPointers: outPointerArray
					outHashes: savedOutHashes) < 0 ifTrue: "no room in outPointers; fail"
		[^self return: PrimErrBadIndex
				restoringObjectsIn: arrayOfObjects savedHashes: savedInHashes
				and: outPointerArray savedHashes: savedOutHashes].

	"We're done.  Shorten the results, restore hashes and return."
	self shorten: segmentWordArray toIndexableSize: segAddr - (segmentWordArray + self baseHeaderSize) / 4.
	self shorten: outPointerArray toIndexableSize: outIndex.
	^self return: PrimNoErr
		restoringObjectsIn: arrayOfObjects savedHashes: savedInHashes
		and: outPointerArray savedHashes: savedOutHashes