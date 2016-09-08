class initialization
initializeSimStackConstants
	"The simulation stack is used to delay code generation until operands are consumed by
	 some operation, thereby avoiding pushing operands to the real stack and enabling
	 mapping stack contents to registers, and cheaply apply various peephole optimizations.
	 The simulation stack is an array of CogSimStackEntry structs.  Each entry defines the
	 object on the virtual stack (Smalltalk context stack) as compilation proceeds.  See
	 stackToRegisterMapping in this class for documentation."

	SSIllegal := 0.
	SSBaseOffset := 1.
	SSConstant := 2.
	SSRegister := 3.
	SSSpill := 4