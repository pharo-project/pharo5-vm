interpreter access
topRemappableOop
	<api>
	"Answers the top of the remappable oop stack. Useful when writing loops.
	 We support this excessence for compatibility with ObjectMemory.
	 Spur doesn't GC during allocation."
	^remapBuffer at: remapBufferCount