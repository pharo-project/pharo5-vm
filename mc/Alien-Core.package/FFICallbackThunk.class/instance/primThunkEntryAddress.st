private-primitives
primThunkEntryAddress "^<Integer>"
	"Answer the address of the entry-point for thunk callbacks:
		long thunkEntry(void *thunkp, long *stackp);
	 This is the function a callback thunk/trampoline should call to initiate a callback."
	<primitive: 'primThunkEntryAddress' error: errorCode module: 'IA32ABI'>
	^self primitiveFailed