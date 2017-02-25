memory access
uint32AtPointer: pointer
	"This gets implemented by Macros in C, where its types will also be checked.
	 pointer is a raw address, and the result is an 32 bit integer."
	<doNotGenerate>

	^self longAt: pointer