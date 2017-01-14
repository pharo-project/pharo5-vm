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
	SSSpill := 4.
	
	" Native simulation stack"
	SSNativeRegister := 5.
	SSRegisterPair := 6.
	SSRegisterDoubleFloat := 7.
	SSRegisterSingleFloat := 8.

	SSSpillNative := 9.
	SSSpillInt64 := 10.
	SSSpillFloat32 := 11.
	SSSpillFloat64 := 12.

	SSConstantInt32 := 13.
	SSConstantInt64 := 14.
	SSConstantFloat32 := 15.
	SSConstantFloat64 := 16.
	SSConstantNativePointer := 17.