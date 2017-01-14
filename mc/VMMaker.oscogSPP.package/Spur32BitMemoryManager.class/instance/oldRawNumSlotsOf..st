object access
oldRawNumSlotsOf: objOop
	<returnTypeC: #usqInt>
	<inline: true>
	self flag: #endianness.
	^(self longAt: objOop + 4) asUnsignedInteger >> self numSlotsHalfShift