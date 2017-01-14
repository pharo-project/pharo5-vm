plugin primitive support
callExternalPrimitive: functionID
	"Call the external plugin function identified. In the VM this is an address;
	 see StackInterpreterSimulator for its version."

	<var: #functionID declareC: 'void (*functionID)()'>
	"Spur needs the primitiveFunctionPointer to be set correctly
	 for accurate following of forwarders on primitive failure."
	objectMemory hasSpurMemoryManagerAPI ifTrue:
		[primitiveFunctionPointer := functionID].
	self dispatchFunctionPointer: functionID.
	self maybeFailForLastObjectOverwrite.