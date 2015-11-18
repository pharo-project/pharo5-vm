class initialization
initialize
	"CogMIPSELCompiler initialize"

	super initialize.
	
	ConcreteVarBaseReg := S6.

	"Simulating a condition register."
	Cmp := T0.
	CmpSLT := T1.
	CmpSGT := T2.
	CmpULT := T3.
	CmpUGT := T4.
	Overflow := T0.
	OverflowTemp1 := T1.
	OverflowTemp2 := T2.

	"OABI position independent code expects T9 to have its entry point on entry?"
	self flag: #OABI.
	TargetReg := T9.

	"Specific instructions"
	self
		initializeSpecificOpcodes: #(MulRR
									AddCheckOverflowCqR AddCheckOverflowRR MulCheckOverflowRR SubCheckOverflowCqR SubCheckOverflowRR
									"Ryan, here are proposed opcodes for conditional branches."
									BrEqRR BrNeRR BrLezRR BrGtzRR)
		in: thisContext method
		
	