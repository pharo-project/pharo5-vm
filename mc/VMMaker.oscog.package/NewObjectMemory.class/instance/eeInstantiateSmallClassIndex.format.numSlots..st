interpreter access
eeInstantiateSmallClassIndex: compactClassIndex format: objFormat numSlots: numSlots
	"This version of instantiateClass assumes that the total object size is under
	 256 bytes, the limit for objects with only one or two header words. 
	 NOTE this code will only work for sizes that are an integral number of words
		(hence not a 32-bit LargeInteger in a 64-bit system).
	 Note that the created small object IS NOT FILLED and must be completed before returning it to Squeak.
	 Since this call is used in routines that do just that we are safe. Break this rule and die in GC.
	 Will *not* cause a GC. Result is guaranteed to be young."

	| sizeInBytes hash header1 |
	"cannot have a negative indexable field count"
	self assert: (numSlots >= 0 and: [compactClassIndex ~= 0]).
	self assert: (objFormat < self firstByteFormat
					ifTrue: [objFormat]
					ifFalse: [objFormat bitAnd: self byteFormatMask])
				= (self instSpecOfClass: (self compactClassAt: compactClassIndex)).
	sizeInBytes := numSlots << self shiftForWord + self baseHeaderSize.
	self assert: sizeInBytes <= 252.
	hash := self newObjectHash.
	header1 := (objFormat << self instFormatFieldLSB
					bitOr: compactClassIndex << 12)
					bitOr: (hash bitAnd: HashMaskUnshifted) << HashBitsOffset.
	header1 := header1 + (sizeInBytes - (header1 bitAnd: SizeMask+Size4Bit)).
	^self eeAllocate: sizeInBytes headerSize: 1 h1: header1 h2: 0 h3: 0