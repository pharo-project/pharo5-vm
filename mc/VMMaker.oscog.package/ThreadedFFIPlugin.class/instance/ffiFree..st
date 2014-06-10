primitive support
ffiFree: pointer
	"Default to malloc/free.  If a platform needs a different allocator define
	 something in the preamble and redefine this to take account of that."
	<cmacro: '(pointer) free((void *)(pointer))'>
	^self