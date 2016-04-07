class initialization
initBytesPerWord: wordSize

	BytesPerWord := BytesPerOop := wordSize.
	"N.B.  This is *not* output when generating the interpreter file.
	 It is left to the various sqConfig.h files to define correctly."
	VMBIGENDIAN := Smalltalk endianness == #big.
	SPURVM := true