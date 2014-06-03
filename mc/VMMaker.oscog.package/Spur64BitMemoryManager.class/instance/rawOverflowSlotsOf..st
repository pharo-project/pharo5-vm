object access
rawOverflowSlotsOf: objOop
	<returnTypeC: #usqLong>
	<inline: true>
	self flag: #endianness.
	^((self longAt: objOop - self baseHeaderSize) << 8) asUnsignedLong >> 8