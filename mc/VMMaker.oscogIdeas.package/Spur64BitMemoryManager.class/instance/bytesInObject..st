object enumeration
bytesInObject: objOop
	"Answer the total number of bytes in an object including header and possible overflow size header."
	<returnTypeC: #usqInt>
	| header headerNumSlots numSlots |
	<var: 'header' type: #usqLong>
	self flag: #endianness.
	header := self longAt: objOop.
	headerNumSlots := header >> self numSlotsFullShift.
	numSlots := headerNumSlots = self numSlotsMask
					ifTrue: [self rawOverflowSlotsOf: objOop]
					ifFalse: [headerNumSlots = 0 ifTrue: [1] ifFalse: [headerNumSlots]].
	^numSlots << self shiftForWord
	+ (headerNumSlots = self numSlotsMask
		ifTrue: [self baseHeaderSize + self baseHeaderSize]
		ifFalse: [self baseHeaderSize])