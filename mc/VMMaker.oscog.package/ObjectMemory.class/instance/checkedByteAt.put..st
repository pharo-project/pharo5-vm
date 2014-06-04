memory access
checkedByteAt: byteAddress put: byte
	"Assumes zero-based array indexing."

	self checkAddress: byteAddress.
	self byteAt: byteAddress put: byte.