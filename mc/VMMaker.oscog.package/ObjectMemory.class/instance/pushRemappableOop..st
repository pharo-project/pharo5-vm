interpreter access
pushRemappableOop: oop
	"Record the given object in a the remap buffer. Objects in this buffer are remapped when a compaction occurs. This facility is used by the interpreter to ensure that objects in temporary variables are properly remapped."
	<api>
	self assert: (self addressCouldBeOop: oop).
	remapBuffer at: (remapBufferCount := remapBufferCount + 1) put: oop.
	remapBufferCount <= RemapBufferSize ifFalse:
		[self error: 'remapBuffer overflow'].