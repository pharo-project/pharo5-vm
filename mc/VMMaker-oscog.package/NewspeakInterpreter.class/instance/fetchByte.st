interpreter shell
fetchByte
	"This method uses the preIncrement builtin function which has no Smalltalk equivalent. Thus, it must be overridden in the simulator."

	^ self byteAtPointer: localIP preIncrement