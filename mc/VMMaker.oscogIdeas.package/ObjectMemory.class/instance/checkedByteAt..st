memory access
checkedByteAt: byteAddress
	"Assumes zero-based array indexing."

	self checkAddress: byteAddress.
	^ self byteAt: byteAddress