primitives - machine specific
primitiveSizeOfInt
	"Size in bytes of an integer, for this C compiler on this machine."

	<export: true>
	interpreterProxy pop: 1; pushInteger: self sizeOfInt