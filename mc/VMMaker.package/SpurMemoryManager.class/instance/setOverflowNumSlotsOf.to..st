free space
setOverflowNumSlotsOf: objOop to: numSlots
	self flag: #endian.
	self long32At: objOop - self baseHeaderSize put: numSlots