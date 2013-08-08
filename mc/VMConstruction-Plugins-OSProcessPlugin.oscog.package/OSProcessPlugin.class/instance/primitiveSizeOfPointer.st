primitives - machine specific
primitiveSizeOfPointer
	"Size in bytes of a void pointer, for this C compiler on this machine."

	<export: true>
	interpreterProxy pop: 1; pushInteger: self sizeOfPointer