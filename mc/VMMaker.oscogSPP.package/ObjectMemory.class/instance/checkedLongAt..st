memory access
checkedLongAt: byteAddress
	"Assumes zero-based array indexing. For testing in Smalltalk, this method should be overridden in a subclass."
	<api>
	self checkAddress: byteAddress.
	self checkAddress: byteAddress + 3.
	^ self longAt: byteAddress