object enumeration
objectStartingAt: address
	"For enumerating objects find the header of the first object in a space.
	 If the object starts with an overflow size field it will start at the next allocationUnit.
	 c.f. numSlotsOf:"
	| halfHeader numSlots |
	self flag: #endianness.
	halfHeader := self longAt: address + 4.
	numSlots := halfHeader >> self numSlotsHalfShift bitAnd: self numSlotsMask.
	^numSlots = self numSlotsMask
		ifTrue: [address + self baseHeaderSize]
		ifFalse: [address]