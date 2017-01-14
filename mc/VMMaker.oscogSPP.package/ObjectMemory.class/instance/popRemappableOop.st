interpreter access
popRemappableOop
	"Pop and return the possibly remapped object from the remap buffer."
	<api>
	| oop |
	oop := remapBuffer at: remapBufferCount.
	remapBufferCount := remapBufferCount - 1.
	^ oop