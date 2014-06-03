free space
setRawNumSlotsOf: objOop to: n
	"Private to free space. See freeSmallObject:"
	self flag: #endian.
	self byteAt: objOop + 7 put: n