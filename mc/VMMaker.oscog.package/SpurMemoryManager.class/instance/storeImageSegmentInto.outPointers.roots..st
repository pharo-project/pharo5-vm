image segment in/out
storeImageSegmentInto: segmentWordArray outPointers: outPointerArray roots: arrayOfRoots
	"This primitive is called from Squeak as...
		<imageSegment> storeSegmentFor: arrayOfRoots into: aWordArray outPointers: anArray."

"This primitive will store a binary image segment (in the same format as the Squeak image file) of the receiver and every object in its proper tree of subParts (ie, that is not refered to from anywhere else outside the tree).  All pointers from within the tree to objects outside the tree will be copied into the array of outpointers.  In their place in the image segment will be an oop equal to the offset in the outPointer array (the first would be 4). but with the high bit set."

"The primitive expects the array and wordArray to be more than adequately long.  In this case it returns normally, and truncates the two arrays to exactly the right size.  To simplify truncation, both incoming arrays are required to have large headers (i.e. be 256 words long or larger).  If either array is too small, the primitive will fail, but in no other case.

During operation of the primitive, it is necessary to convert from both internal and external oops to their mapped values.  To make this fast, the original objects in question are forwarded to the mapped values.  Tables are kept of both kinds of oops.  Note that markObjects eliminates forwarding pointers, so there will be no forwarding pointers in the object graph once objects have been marked.

To be specific, there are two similar tables, the outPointer array, and one in the upper eight of the segmentWordArray.  Each grows oops from the bottom up.

In case of either success or failure, the headers must be restored.  In the event of primitive failure, the table of outPointers must also be nilled out (since the garbage in the high half will not have been discarded)."

	| endSeg firstIn firstOut lastIn lastOut limitSeg scanned newSegLimit unmarkedClasses |
	true ifTrue: [^PrimErrUnsupported] ifFalse: [

	((self hasOverflowHeader: outPointerArray)						"Must have 128-bit header"
	and: [self hasOverflowHeader: segmentWordArray]) ifFalse:		"Must have 128-bit header"
		[^PrimErrGenericFailure].

	firstOut := outPointerArray + self baseHeaderSize.
	lastOut := firstOut - self bytesPerOop.

	limitSeg := segmentWordArray + self baseHeaderSize.
	endSeg := segmentWordArray + (self addressAfter: segmentWordArray).

	"Allocate top 1/8 of segment for table of internal oops"
	firstIn := endSeg - ((self numSlotsOf: segmentWordArray) // 8).  "Take 1/8 of seg"
	lastIn := firstIn - self bytesPerOop.

	"N.B.  A side effect of this marking is that all forwarders are followed,
	 so while forwarders may exist in te heap they will *not* be reachable."
	self markAllExceptTransitiveClosureOf: arrayOfRoots.

	"All external objects, and only they, are now marked."
	unmarkedClasses := self arrayOfUnmarkedClasses.
	(self isImmediate: unmarkedClasses) ifTrue:
		[^PrimErrGenericFailure].

	"Write a version number for byte order and version check, followed by the number of classes."
	limitSeg >= endSeg ifTrue: [^PrimErrGenericFailure].
	self long32At: limitSeg put: self imageSegmentVersion.
	self long32At: limitSeg + 4 put: (self numSlotsOf: unmarkedClasses).
	scanned := limitSeg := limitSeg + 8.

	"If there are any classes then copy them into the segment, and forward their oop."
	(self numSlotsOf: unmarkedClasses) > 0 ifTrue:
		[((lastIn := lastIn + self bytesPerOop) >= endSeg
		 or: [0 = (newSegLimit := self copyObj: arrayOfRoots toSegment: segmentWordArray addr: limitSeg stopAt: firstIn saveOopAt: lastIn)]) ifTrue:
			[lastIn := lastIn - self bytesPerWord.
			self restoreObjectsFrom: firstIn to: lastIn from: segmentWordArray + self baseHeaderSize to: limitSeg.
			self fillObj: outPointerArray numSlots: (self numSlotsOf: outPointerArray) with: nilObj.
			^PrimErrGenericFailure].
		limitSeg := newSegLimit].

	"Copy the array of roots into the segment, and forward its oop."
	((lastIn := lastIn + self bytesPerOop) >= endSeg
	 or: [0 = (newSegLimit := self copyObj: arrayOfRoots toSegment: segmentWordArray addr: limitSeg stopAt: firstIn saveOopAt: lastIn)]) ifTrue:
		[lastIn := lastIn - self bytesPerWord.
		self restoreObjectsFrom: firstIn to: lastIn from: segmentWordArray + self baseHeaderSize to: limitSeg.
		self fillObj: outPointerArray numSlots: (self numSlotsOf: outPointerArray) with: nilObj.
		^PrimErrGenericFailure].
	limitSeg := newSegLimit.

	"Now traverse the objects copied to the segment so far, copying unmarked objects into the segment.
	 This is essentially the same algorithm as the breadth-first copying algorithm in scavenging."
	scanned := self objectStartingAt: scanned.
	[scanned < limitSeg] whileTrue:	
		[1 to: (self numPointerSlotsOf: scanned) do:
			[:i| | oop |
			 oop := self fetchPointer: i ofObject: scanned.
			 ((self isImmediate: oop) or: [(self isForwarded: oop) or: [self isMarked: oop]]) ifFalse:
				[((lastIn := lastIn + self bytesPerOop) >= endSeg
				  or: [0 = (newSegLimit := self copyObj: oop toSegment: segmentWordArray addr: limitSeg stopAt: firstIn saveOopAt: lastIn)]) ifTrue:
					[lastIn := lastIn - self bytesPerWord.
					self restoreObjectsFrom: firstIn to: lastIn from: segmentWordArray + self baseHeaderSize to: limitSeg.
					self fillObj: outPointerArray numSlots: (self numSlotsOf: outPointerArray) with: nilObj.
					^PrimErrGenericFailure].
				 limitSeg := newSegLimit]].
		scanned := self objectAfter: scanned].

	"Now the primitive can not fail; traverse the objects in the segment, unforwarding the originals and mapping external oops."
	self flag: 'you are here']