object enumeration
bytesInObject: objOop given: rawNumSotsOfObjOop
	"Answer the total number of bytes in an object including header and possible overflow size header, given the value of the object's numSlots field."
	<returnTypeC: #usqInt>
	<inline: true>
	| numSlots |
	numSlots := rawNumSotsOfObjOop = self numSlotsMask
					ifTrue: [self rawOverflowSlotsOf: objOop]
					ifFalse: [rawNumSotsOfObjOop = 0 ifTrue: [1] ifFalse: [rawNumSotsOfObjOop]].
	^numSlots << self shiftForWord
	+ (rawNumSotsOfObjOop = self numSlotsMask
		ifTrue: [self baseHeaderSize + self baseHeaderSize]
		ifFalse: [self baseHeaderSize])