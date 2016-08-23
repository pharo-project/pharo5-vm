object access
rawOverflowSlotsOf: objOop
	<returnTypeC: #usqInt>
	<inline: true>
	self flag: #endianness.
	^self longAt: objOop - self baseHeaderSize