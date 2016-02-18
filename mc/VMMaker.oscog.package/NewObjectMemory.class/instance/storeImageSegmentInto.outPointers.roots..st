image segment in/out
storeImageSegmentInto: segmentWordArray outPointers: outPointerArray roots: arrayOfRoots

"This primitive will store a binary image segment (in the same format as the Squeak image file) of the receiver and every object in its proper tree of subParts (ie, that is not refered to from anywhere else outside the tree).  All pointers from within the tree to objects outside the tree will be copied into the array of outpointers.  In their place in the image segment will be an oop equal to the offset in the outPointer array (the first would be 4). but with the high bit set."

"The primitive expects the array and wordArray to be more than adequately long.  In this case it returns normally, and truncates the two arrays to exactly the right size.  To simplify truncation, both incoming arrays are required to be 256 bytes or more long (ie with 3-word headers).  If either array is too small, the primitive will fail, but in no other case.

During operation of the primitive, it is necessary to convert from both internal and external oops to their mapped values.  To make this fast, the headers of the original objects in question are replaced by the mapped values (and this is noted by adding the forbidden XX header type).  Tables are kept of both kinds of oops, as well as of the original headers for restoration.

To be specific, there are two similar two-part tables, the outpointer array, and one in the upper fifth of the segmentWordArray.  Each grows oops from the bottom up, and preserved headers from halfway up.

In case of either success or failure, the headers must be restored.  In the event of primitive failure, the table of outpointers must also be nilled out (since the garbage in the high half will not have been discarded."

	| savedYoungStart lastOut lastIn firstIn lastSeg endSeg segOop fieldPtr fieldOop mapOop
	  doingClass lastPtr extraSize hdrTypeBits hdrBaseIn hdrBaseOut header firstOut versionOffset |
	<inline: false>
	<var: #firstIn type: #usqInt>
	<var: #lastIn type: #usqInt>
	<var: #firstOut type: #usqInt>
	<var: #lastOut type: #usqInt>
	<var: #hdrBaseIn type: #usqInt>
	<var: #hdrBaseOut type: #usqInt>
	<var: #lastSeg type: #usqInt>
	<var: #endSeg type: #usqInt>
	<var: #fieldPtr type: #usqInt>
	<var: #lastPtr type: #usqInt>
	<var: #segOop type: #usqInt>
	<var: #savedYoungStart type: #usqInt>

	((self headerType: outPointerArray) = HeaderTypeSizeAndClass			"Must be 3-word header"
	and: [(self headerType: segmentWordArray) = HeaderTypeSizeAndClass])	"Must be 3-word header"
		ifFalse: [^PrimErrGenericFailure].

	DoAssertionChecks ifTrue: [self verifyCleanHeaders].
	"Use the top half of outPointers for saved headers."
	firstOut := outPointerArray + self baseHeaderSize.
	lastOut := firstOut - self wordSize.
	hdrBaseOut := outPointerArray + ((self lastPointerOf: outPointerArray) // (self wordSize*2) * self wordSize). "top half"

	lastSeg := segmentWordArray.
	endSeg := segmentWordArray + (self sizeBitsOf: segmentWordArray) - self wordSize.

	"Write a version number for byte order and version check"
	versionOffset := self wordSize.
	lastSeg := lastSeg + versionOffset.
	lastSeg > endSeg ifTrue: [^PrimErrGenericFailure].
	self longAt: lastSeg put: self imageSegmentVersion.

	"Allocate top 1/8 of segment for table of internal oops and saved headers"
	firstIn := endSeg - ((self sizeBitsOf: segmentWordArray) // (self wordSize*8) * self wordSize).  "Take 1/8 of seg"
	lastIn := firstIn - self wordSize.
	hdrBaseIn := firstIn + ((self sizeBitsOf: segmentWordArray) // (self wordSize*16) * self wordSize). "top half of that"

	"First mark the rootArray and all root objects."
	self longAt: arrayOfRoots put: ((self longAt: arrayOfRoots) bitOr: MarkBit).
	lastPtr := arrayOfRoots + (self lastPointerOf: arrayOfRoots).
	fieldPtr := arrayOfRoots + self baseHeaderSize.
	[fieldPtr <= lastPtr] whileTrue:
		[fieldOop := self longAt: fieldPtr.
		(self isIntegerObject: fieldOop) ifFalse:
			[self longAt: fieldOop put: ((self longAt: fieldOop) bitOr: MarkBit)].
		fieldPtr := fieldPtr + self wordSize].

	"Then do a mark pass over all objects.  This will stop at our marked roots,
	thus leaving our segment unmarked in their shadow."
	savedYoungStart := youngStart.
	youngStart := self startOfMemory.  "process all of memory"
	self markAndTraceInterpreterOops: false.	"and special objects array"
	youngStart := savedYoungStart.
	
	"Finally unmark the rootArray and all root objects."
	self longAt: arrayOfRoots put: ((self longAt: arrayOfRoots) bitAnd: AllButMarkBit).
	fieldPtr := arrayOfRoots + self baseHeaderSize.
	[fieldPtr <= lastPtr] whileTrue:
		[fieldOop := self longAt: fieldPtr.
		(self isIntegerObject: fieldOop) ifFalse:
			[self longAt: fieldOop put: ((self longAt: fieldOop) bitAnd: AllButMarkBit)].
		fieldPtr := fieldPtr + self wordSize].

	"All external objects, and only they, are now marked.
	Copy the array of roots into the segment, and forward its oop."
	lastIn := lastIn + self wordSize.
	(lastIn >= hdrBaseIn
	 or: [0 = (lastSeg := self copyObj: arrayOfRoots toSegment: segmentWordArray addr: lastSeg stopAt: firstIn saveOopAt: lastIn headerAt: hdrBaseIn + (lastIn - firstIn))]) ifTrue:
		[lastIn := lastIn - self wordSize.
		self restoreHeadersFrom: firstIn to: lastIn from: hdrBaseIn and: firstOut to: lastOut from: hdrBaseOut.
		^self primitiveFailCodeAfterCleanup: outPointerArray].

	"Now run through the segment fixing up all the pointers.
	Note that more objects will be added to the segment as we make our way along."
	segOop := self oopFromChunk: segmentWordArray + versionOffset + self baseHeaderSize.
	[segOop <= lastSeg] whileTrue:
		[(self headerType: segOop) <= 1
			ifTrue: ["This object has a class field (type=0 or 1) -- start with that."
					fieldPtr := segOop - self wordSize.  doingClass := true]
			ifFalse: ["No class field -- start with first data field"
					fieldPtr := segOop + self baseHeaderSize.  doingClass := false].
		lastPtr := segOop + (self lastPointerOf: segOop).	"last field"

		"Go through all oops, remapping them..."
		[fieldPtr > lastPtr] whileFalse:
			["Examine each pointer field"
			fieldOop := self longAt: fieldPtr.
			doingClass ifTrue:
				[hdrTypeBits := fieldOop bitAnd: TypeMask.
				fieldOop := fieldOop - hdrTypeBits].
			(self isIntegerObject: fieldOop)
				ifTrue: ["Just an integer -- nothing to do"
						fieldPtr := fieldPtr + self wordSize]
				ifFalse:
				[header := self longAt: fieldOop.
				(header bitAnd: TypeMask) = HeaderTypeFree
					ifTrue: ["Has already been forwarded -- this is the link"
							mapOop := header bitAnd: AllButTypeMask]
					ifFalse:
					[((self longAt: fieldOop) bitAnd: MarkBit) = 0
						ifTrue:
							["Points to an unmarked obj -- an internal pointer.
							Copy the object into the segment, and forward its oop."
							lastIn := lastIn + self wordSize.
							(lastIn >= hdrBaseIn
							or: [0 = (lastSeg := self copyObj: fieldOop toSegment: segmentWordArray addr: lastSeg stopAt: firstIn saveOopAt: lastIn headerAt: hdrBaseIn + (lastIn - firstIn))]) ifTrue:
								["Out of space in segment"
								lastIn := lastIn - self wordSize.
								self restoreHeadersFrom: firstIn to: lastIn from: hdrBaseIn and: firstOut to: lastOut from: hdrBaseOut.
								^self primitiveFailCodeAfterCleanup: outPointerArray].
							mapOop := (self longAt: fieldOop) bitAnd: AllButTypeMask]
						ifFalse:
							["Points to a marked obj -- an external pointer.
							Map it as a tagged index in outPointers, and forward its oop."
							lastOut := lastOut + self wordSize.
							lastOut >= hdrBaseOut ifTrue:
								["Out of space in outPointerArray"
								lastOut := lastOut - self wordSize.
								self restoreHeadersFrom: firstIn to: lastIn from: hdrBaseIn and: firstOut to: lastOut from: hdrBaseOut.
								^self primitiveFailCodeAfterCleanup: outPointerArray].
.							mapOop := lastOut - outPointerArray bitOr: 16r80000000.
							self forward: fieldOop to: mapOop
								savingOopAt: lastOut andHeaderAt: hdrBaseOut + (lastOut - firstOut)]].
					"Replace the oop by its mapped value"
					doingClass
						ifTrue: [self longAt: fieldPtr put: mapOop + hdrTypeBits.
								fieldPtr := fieldPtr + (self wordSize*2).
								doingClass := false]
						ifFalse: [self longAt: fieldPtr put: mapOop.
								fieldPtr := fieldPtr + self wordSize]]].
		segOop := self objectAfter: segOop].

	self restoreHeadersFrom: firstIn to: lastIn from: hdrBaseIn and: firstOut to: lastOut from: hdrBaseOut.

	"Truncate the outPointerArray..."
	((outPointerArray + (self lastPointerOf: outPointerArray) - lastOut) < 12
		or: [(endSeg - lastSeg) < 12]) ifTrue:
			["Not enough room to insert simple 3-word headers"
			^self primitiveFailCodeAfterCleanup: outPointerArray].
	extraSize := self extraHeaderBytes: segmentWordArray.
	hdrTypeBits := self headerType: segmentWordArray.
	"Copy the 3-word wordArray header to establish a free chunk."
	self transfer: 3
		from: segmentWordArray - extraSize
		to: lastOut+self wordSize.
	"Adjust the size of the original as well as the free chunk."
	self longAt: lastOut+self wordSize
		put: outPointerArray + (self lastPointerOf: outPointerArray) - lastOut - extraSize + hdrTypeBits.
	self longAt: outPointerArray-extraSize
		put: lastOut - firstOut + (self wordSize*2) + hdrTypeBits.
	"Note that pointers have been stored into roots table"
	self beRootIfOld: outPointerArray.

	"Truncate the image segment..."
	"Copy the 3-word wordArray header to establish a free chunk."
	self transfer: 3
		from: segmentWordArray - extraSize
		to: lastSeg+self wordSize.
	"Adjust the size of the original as well as the free chunk."
	self longAt: segmentWordArray-extraSize
		put: lastSeg - segmentWordArray + self baseHeaderSize + hdrTypeBits.
	self longAt: lastSeg+self wordSize
		put: endSeg - lastSeg - extraSize + hdrTypeBits.

	DoAssertionChecks ifTrue: [self verifyCleanHeaders].
	^PrimNoErr