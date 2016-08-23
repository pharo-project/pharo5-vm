class initialization
initialize
	"CogRTLOpcodes initialize. CogMIPSELCompiler initialize"

	super initialize.
	
	ConcreteVarBaseReg := S6.

	Cmp := T0.

	Overflow := T0.
	OverflowTemp1 := T1.
	OverflowTemp2 := T2.
	
	"Can't use AT, Cmp or Overflow because we may need to preserve them for sequences like
	 CmpCwR
	 JumpZero
	 JumpBelow"
	BranchTemp := T3.

	"OABI position independent code expects T9 to have its entry point on entry?"
	self flag: #OABI.
	TargetReg := T9.

	"Specific instructions"
	self initializeSpecificOpcodes: #(
		MulRR
		DivRR
		MoveLowR
		MoveHighR
		AddCheckOverflowCqR 
		AddCheckOverflowRR
		MulCheckOverflowRR
		SubCheckOverflowCqR
		SubCheckOverflowRR
		BrEqualRR
		BrNotEqualRR 
		BrUnsignedLessRR
		BrUnsignedLessEqualRR
		BrUnsignedGreaterRR
		BrUnsignedGreaterEqualRR
		BrSignedLessRR
		BrSignedLessEqualRR
		BrSignedGreaterRR
		BrSignedGreaterEqualRR
		BrLongEqualRR
		BrLongNotEqualRR) 
			in: thisContext method
		
	