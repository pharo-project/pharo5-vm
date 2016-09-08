object access
rawNumSlotsOf: objOop put: aByte
	<returnTypeC: #usqInt>
	<inline: true>
	self flag: #endian.
	^self byteAt: objOop + 7 put: aByte