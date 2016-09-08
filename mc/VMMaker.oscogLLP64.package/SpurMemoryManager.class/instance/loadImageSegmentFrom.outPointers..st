image segment in/out
loadImageSegmentFrom: segmentWordArray outPointers: outPointerArray
	"This primitive is called from Squeak as...
		<imageSegment> loadSegmentFrom: aWordArray outPointers: anArray."

	"This primitive will load a binary image segment created by primitiveStoreImageSegment.
	 It expects the outPointer array to be of the proper size, and the wordArray to be well formed.
	 It will return as its value the original array of roots, and the segmentWordArray will become an
	 array of the loaded objects.  If this primitive should fail, the segmentWordArray will, sadly, have
	 been reduced to an unrecognizable and unusable jumble.  But what more could you have done
	 with it anyway?"

	<inline: false>
	| segmentLimit segmentStart segVersion errorCode numLoadedObjects loadedObjectsArray |

	segmentLimit := self numSlotsOf: segmentWordArray.
	(self objectBytesForSlots: segmentLimit) < (self allocationUnit "version info" + self baseHeaderSize "one object header") ifTrue:
		[^PrimErrBadArgument].

	"Verify format.  If the format is wrong, word-swap (since ImageSegment data are 32-bit longs).
	 If it is still wrong, undo the damage and fail."
	segVersion := self longAt: segmentWordArray + self baseHeaderSize.
	(coInterpreter readableFormat: (segVersion bitAnd: 16rFFFFFF "low 3 bytes")) ifFalse:
		[self reverseBytesIn32BitWordsFrom: segmentWordArray + self baseHeaderSize
			to: (self addressAfter: segmentWordArray).
		 segVersion := self longAt: segmentWordArray + self baseHeaderSize.
		 (coInterpreter readableFormat: (segVersion bitAnd: 16rFFFFFF "low 3 bytes")) ifFalse:
			[self reverseBytesIn32BitWordsFrom: segmentWordArray + self baseHeaderSize
				to: (self addressAfter: segmentWordArray).
			 ^PrimErrBadArgument]].

	segmentStart := segmentWordArray + self baseHeaderSize + self allocationUnit.
	segmentLimit := segmentLimit * self bytesPerOop + segmentWordArray + self baseHeaderSize.

	"Notionally reverse the Byte type objects if the data is from opposite endian machine.
	 Test top byte.  $d on the Mac or $s on the PC.  Rest of word is equal.  If Spur is ever
	 ported to big-endian machines then the segment may have to be byte/word swapped,
	 but so far it only runs on little-endian machines, so for now just fail if endinanness is wrong."
	self flag: #endianness.
	(segVersion >> 24 bitAnd: 16rFF) ~= (self imageSegmentVersion >> 24 bitAnd: 16rFF) ifTrue:
		"Reverse the byte-type objects once"
		[true
			ifTrue: [^PrimErrBadArgument]
			ifFalse:
				[self byteSwapByteObjectsFrom: (self objectStartingAt: segmentStart)
					to: segmentLimit
					flipFloatsIf: false]].

	"scan through mapping oops and validating class references. Defer entering any
	 class objects into the class table and/or pinning objects until a second pass."
	errorCode := self mapOopsAndValidateClassRefsFrom: segmentStart to: segmentLimit outPointers: outPointerArray.
	errorCode > 0 ifTrue:
		[^errorCode].
	numLoadedObjects := errorCode negated.
	loadedObjectsArray := self allocateSlots: numLoadedObjects format: self arrayFormat classIndex: ClassArrayCompactIndex.
	loadedObjectsArray ifNil:
		[^PrimErrNoMemory].

	"Scan for classes contained in the segment, entering them into the class table.
	 Classes are at the front, after the root array and have the remembered bit set."
	errorCode := self enterClassesIntoClassTableFrom: segmentStart to: segmentLimit.
	errorCode ~= 0 ifTrue:
		[^errorCode].

	"Make a final pass, assigning class indices and/or pinning pinned objects and collecting the loaded objects in loadedObjectsArray"
	self assignClassIndicesAndPinFrom: segmentStart to: segmentLimit outPointers: outPointerArray filling: loadedObjectsArray.

	"Evaporate the container, leaving the newly loaded objects in place."
	(self hasOverflowHeader: segmentWordArray)
		ifTrue: [self rawOverflowSlotsOf: segmentWordArray put: self allocationUnit / self bytesPerOop]
		ifFalse: [self rawNumSlotsOf: segmentWordArray put: self allocationUnit / self bytesPerOop].

	"Finally forward the segmentWordArray to the loadedObjectsArray"
	self forward: segmentWordArray to: loadedObjectsArray.
	
	self runLeakCheckerFor: GCModeImageSegment.

	^self objectStartingAt: segmentStart