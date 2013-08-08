primitive support
ffiAlloc: bytes
	"Default to malloc/free.  If a platform needs a different allocator define
	 something in the preamble and redefine this to take account of that."
	<cmacro: '(bytes) (usqInt)malloc(bytes)'>
	^ByteArray new: bytes