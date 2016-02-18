return bytecodes
maybeReturnToMachineCodeFrame
	"Hook for the CoInterpreter to return to machine-code or
	 load the saved IP.  This is a nop in the StackInterpreter."