memory access
byteAtPointer: pointer
	"This gets implemented by Macros in C, where its types will also be checked.
	pointer is a raw address, and byte is an 8-bit quantity."

	^ self byteAt: pointer