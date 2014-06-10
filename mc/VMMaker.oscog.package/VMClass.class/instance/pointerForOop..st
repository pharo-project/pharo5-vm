translation support
pointerForOop: oop
	"This gets implemented by Macros in C, where its types will also be checked.
	 oop is the width of a machine word, and pointer is a raw address."
	<doNotGenerate>

	^oop