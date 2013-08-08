primitives-callbacks
primThunkEntryAddress
	"Answer the address of the entry-point for thunk callbacks:
		long thunkEntry(void *thunkp, long *stackp);
	 This could be derived via loadModule: findSymbol: etc but that would
	preclude making the plugin internal."
	| address |
	<export: true>
	address := self cCode: '(sqInt)thunkEntry' inSmalltalk: [0].
	interpreterProxy methodReturnValue: (interpreterProxy positive32BitIntegerFor: address)