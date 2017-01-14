object access
rawOverflowSlotsOf: objOop put: numSlots
	<returnTypeC: #usqInt>
	<inline: true>
	self flag: #endianness.
	^self longAt: objOop - self baseHeaderSize put: numSlots