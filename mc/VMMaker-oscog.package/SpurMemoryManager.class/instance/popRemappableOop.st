interpreter access
popRemappableOop
	"Pop and return the possibly remapped object from the remap buffer.
	 We support this excessence for compatibility with ObjectMemory.
	 Spur doesn't GC during allocation."
	<api>
	| oop |
	oop := remapBuffer at: remapBufferCount.
	remapBufferCount := remapBufferCount - 1.
	^oop