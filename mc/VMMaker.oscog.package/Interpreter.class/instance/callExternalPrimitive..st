plugin primitive support
callExternalPrimitive: functionID
	"Call the external plugin function identified. In the VM this is an address, see 	InterpreterSimulator for it's version. "

	<var: #functionID type: 'void *'>
	self dispatchFunctionPointer: functionID