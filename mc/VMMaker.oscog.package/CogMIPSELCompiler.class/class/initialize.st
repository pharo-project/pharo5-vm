as yet unclassified
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

	"OABI position independent code expects T9 to have its entry point on entry?"
	self flag: #OABI.
	TargetReg := T9. 