interpreter access
eeInstantiateSmallClass: classPointer numSlots: numSlots
	"This version of instantiateClass assumes that the total object size is under
	 256 bytes, the limit for objects with only one or two header words. 
	 NOTE this code will only work for sizes that are an integral number of words
		(hence not a 32-bit LargeInteger in a 64-bit system).
	 Note that the created small object IS NOT FILLED and must be completed before returning it to Squeak.
	 Since this call is used in routines that do just that we are safe. Break this rule and die in GC.
	 Will *not* cause a GC. Result is guaranteed to be young."

	| sizeInBytes hash header1 header2 hdrSize |
	sizeInBytes := numSlots << self shiftForWord + self baseHeaderSize.
	self assert: sizeInBytes <= 252.
	hash := self newObjectHash.
	header1 := (hash bitAnd: HashMaskUnshifted) << HashBitsOffset bitOr: (self formatOfClass: classPointer).
	header2 := classPointer.
	hdrSize := (header1 bitAnd: CompactClassMask) > 0 "is this a compact class"
				ifTrue: [1]
				ifFalse: [2].
	header1 := header1 + (sizeInBytes - (header1 bitAnd: SizeMask+Size4Bit)).
	^self eeAllocate: sizeInBytes headerSize: hdrSize h1: header1 h2: header2 h3: 0