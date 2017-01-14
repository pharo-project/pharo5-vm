frame access
ensureContextHasBytecodePC: aContext
	"Make sure the context has a byetcode pc.  Can only be used on single contexts.
	 This is a nop in the StackInterpreter."