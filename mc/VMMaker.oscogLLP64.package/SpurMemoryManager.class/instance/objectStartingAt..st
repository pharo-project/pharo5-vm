object enumeration
objectStartingAt: address
	"For enumerating objects find the header of the first object in a space.
	 If the object starts with an overflow size field it will start at the next allocationUnit.
	 c.f. numSlotsOf:"
	| numSlots |
	numSlots := self rawNumSlotsOf: address.
	^numSlots = self numSlotsMask
		ifTrue: [address + self baseHeaderSize]
		ifFalse: [address]