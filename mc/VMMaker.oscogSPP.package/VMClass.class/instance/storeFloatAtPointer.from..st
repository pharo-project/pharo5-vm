memory access
storeFloatAtPointer: pointer from: aFloat
	"This gets implemented by Macros in C, where its types will also be checked.
	 pointer is a raw address, and aFloat is a 64-bit double precision float."
	<doNotGenerate>

	^self storeFloatAt: pointer from: aFloat