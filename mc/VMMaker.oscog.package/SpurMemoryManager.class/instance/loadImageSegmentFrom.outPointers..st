image segment in/out
loadImageSegmentFrom: segmentWordArray outPointers: outPointerArray
	"This primitive is called from Squeak as...
		<imageSegment> loadSegmentFrom: aWordArray outPointers: anArray."

	"This primitive will load a binary image segment created by primitiveStoreImageSegment.
	 It expects the outPointer array to be of the proper size, and the wordArray to be well formed.
	 It will return as its value the original array of roots, and the erstwhile segmentWordArray will
	 have been truncated to a size of one word, i.e. retaining the version stamp.  If this primitive
	 should fail, the segmentWordArray will, sadly, have been reduced to an unrecognizable and
	 unusable jumble.  But what more could you have done with it anyway?"

	<inline: false>
	| segmentLimit segmentStart segVersion errorCode |

	segmentLimit := self numSlotsOf: segmentWordArray.
	(self objectBytesForSlots: segmentLimit) < (self allocationUnit "version info" + self baseHeaderSize "one object header") ifTrue:
		[^PrimErrBadArgument].

	"First thing is to verify format.  If Spur is ever ported to big-endian machines then the segment
	 may have to be byte/word swapped, but so far it only runs on little-endian machines, so for now
	 just fail if endinanness is wrong."
	segVersion := self longAt: segmentWordArray + self baseHeaderSize.
	(coInterpreter readableFormat: (segVersion bitAnd: 16rFFFF "low 2 bytes")) ifFalse:
		[self reverseBytesFrom: segmentWordArray + self baseHeaderSize
			to: (self addressAfter: segmentWordArray).
		 segVersion := self longAt: segmentWordArray + self baseHeaderSize.
		 (coInterpreter readableFormat: (segVersion bitAnd: 16rFFFF "low 2 bytes")) ifFalse:
			[self reverseBytesFrom: segmentWordArray + self baseHeaderSize
				to: (self addressAfter: segmentWordArray).
		^PrimErrBadArgument]].

	segmentStart := segmentWordArray + self baseHeaderSize + self allocationUnit.
	segmentLimit := segmentLimit * self bytesPerOop + segmentWordArray + self baseHeaderSize.

	"Notionally reverse the Byte type objects if the data is from opposite endian machine.
	 Test top byte.  $d on the Mac or $s on the PC.  Rest of word is equal.  If Spur is ever
	 ported to big-endian machines then the segment may have to be byte/word swapped,
	 but so far it only runs on little-endian machines, so for now just fail if endinanness is wrong."
	self flag: #endianness.
	(segVersion >> 16) ~= (self imageSegmentVersion >> 16) ifTrue:
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
	errorCode ~= 0 ifTrue:
		[^errorCode].

	"Scan for classes contained in the segment, entering them into the class table.
	 Classes are at the front, after the root array and have the remembered bit set."
	errorCode := self enterClassesIntoClassTableFrom: segmentStart to: segmentLimit.
	errorCode ~= 0 ifTrue:
		[^errorCode].

	"Make a final pass, assigning class indices and/or pinning pinned objects"
	self assignClassIndicesAndPinFrom: segmentStart to: segmentLimit outPointers: outPointerArray.

	"Finally evaporate the container, leaving the newly loaded objects in place."
	(self hasOverflowHeader: segmentWordArray)
		ifTrue: [self setOverflowNumSlotsOf: segmentWordArray to: self allocationUnit / self bytesPerOop]
		ifFalse: [self setRawNumSlotsOf: segmentWordArray to: self allocationUnit / self bytesPerOop].
	
	self leakCheckImageSegments ifTrue:
		[self runLeakCheckerForFullGC: true].

	^self objectStartingAt: segmentStart