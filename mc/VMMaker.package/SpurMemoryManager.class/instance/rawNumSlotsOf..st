object access
rawNumSlotsOf: objOop
	<returnTypeC: #usqInt>
	<inline: true>
	self flag: #endian.
	^self byteAt: objOop + 7