object enumeration
oopOfObjectStartingAt: address
	"Answer the oop of the memory chunk starting at address, which is either the address
	 of the overflow size word, or objOop itself, depending on the size of the object."
	self flag: #endianness.
	^(self longAt: address) >> self numSlotsHalfShift = self numSlotsMask
		ifTrue: [address + self baseHeaderSize]
		ifFalse: [address]