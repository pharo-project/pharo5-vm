memory access
storeSingleFloatAtPointer: pointer from: aFloat
	"This gets implemented by Macros in C, where its types will also be checked.
	 pointer is a raw address, and aFloat is a 32-bit single precision float."
	<doNotGenerate>

	^self storeSingleFloatAt: pointer from: aFloat