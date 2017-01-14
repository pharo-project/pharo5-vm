object access
rawOverflowSlotsOf: objOop put: numSlots
	<returnTypeC: #usqLong>
	<inline: true>
	self flag: #endianness.
	self longAt: objOop - self baseHeaderSize put: self numSlotsMask << 56 + numSlots.
	^numSlots