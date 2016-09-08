accessing
startOfMemory
	"Return the start of object memory.  This is immediately after the native code zone.
	 N.B. the stack zone is alloca'ed. Use a macro so as not to punish the debug VM."
	<cmacro: '() heapBase'>
	<returnTypeC: #usqInt>
	^coInterpreter heapBase