memory access
long64AtPointer: pointer
	"This gets implemented by Macros in C, where its types will also be checked.
	 pointer is a raw address, and the result is the width of a machine word."
	<doNotGenerate>

	^self halt