object enumeration
bytesInObject: objOop
	"Answer the total number of bytes in an object including header and possible overflow size header."
	<returnTypeC: #usqLong>
	| halfHeader headerNumSlots numSlots |
	self flag: #endianness.
	halfHeader := self longAt: objOop + 4.
	headerNumSlots := halfHeader >> self numSlotsHalfShift bitAnd: self numSlotsMask.
	numSlots := headerNumSlots = self numSlotsMask
					ifTrue: [self longAt: objOop - self baseHeaderSize]
					ifFalse: [headerNumSlots = 0 ifTrue: [1] ifFalse: [headerNumSlots]].
	^numSlots + (numSlots bitAnd: 1) << self shiftForWord
	+ (headerNumSlots = self numSlotsMask
		ifTrue: [self baseHeaderSize + self baseHeaderSize]
		ifFalse: [self baseHeaderSize])