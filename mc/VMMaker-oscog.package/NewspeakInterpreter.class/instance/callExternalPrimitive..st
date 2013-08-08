plugin primitive support
callExternalPrimitive: functionID
	"Call the external plugin function identified. In the VM this is an address;
	 see NewspeakInterpreterSimulator for its version."

	<var: #functionID declareC: 'void (*functionID)()'>
	self dispatchFunctionPointer: functionID