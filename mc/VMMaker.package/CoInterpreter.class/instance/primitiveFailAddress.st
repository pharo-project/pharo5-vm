trampoline support
primitiveFailAddress
	"This is used for asserts that check that inline cache editing results in valid addresses.
	 In the C VM interpret is presumed to come before any primitives and so it constitutes
	 the lowest address in C code that machine code should be linked, but optimizing
	 compilers change things around.  In the simulator we just answer something not low."
	<api>
	<returnTypeC: #usqInt>
	^self cCode: [(self addressOf: #primitiveFail) asUnsignedInteger]
		inSmalltalk: [heapBase]