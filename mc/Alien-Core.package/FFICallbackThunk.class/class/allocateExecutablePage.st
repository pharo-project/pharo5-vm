executable page management
allocateExecutablePage "^<Alien>"
	"Answer an Alien around a piece of (probably malloced) memory, of some multiple
	 of the pagesize, that has execute permissions set.  This memory can be parcelled
	 out to individual FFICallbackThunks to hold their thunk/trampoline machine code."
	<primitive: 'primAllocateExecutablePage' error: errorCode module: 'IA32ABI'>
	^self primitiveFailed