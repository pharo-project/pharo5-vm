class initialization
initialize
	
	"Initialize various ARM instruction-related constants."
	"CogARMCompiler initialize"
	
	| specificOpcodes refs conditionCodes |
	super initialize.
	self ~~ CogARMCompiler ifTrue: [^self].
	
	R0 := 0. R1 := 1.
	R2 := 2. R3 := 3.
	R4 := 4. R5 := 5.
	R6 := 6. R7 := 7.
	R8 := 8. R9 := 9.
	R10 := 10. R11 := 11.
	R12 := 12.
	SP := 13.
	LR := 14.
	PC := 15.
	
	CArg0Reg := 0. CArg1Reg := 1. CArg2Reg := 2. CArg3Reg := 3.
	
	RISCTempReg := R10.
	
	"Condition Codes"
	conditionCodes := #(EQ NE CS CC MI PL VS VC HI LS GE LT GT LE AL).
	conditionCodes withIndexDo: [ :classVarName :value | 
		self classPool
			declare: classVarName from: Undeclared;
			at: classVarName put: value - 1].
	
	"Specific instructions"
	LastRTLCode isNil ifTrue:
		[CogRTLOpcodes initialize].
	specificOpcodes := #(LDMFD STMFD).
	refs := (thisContext method literals select: [:l| l isVariableBinding and: [classPool includesKey: l key]]) collect:
				[:ea| ea key].
	(classPool keys reject: [:k| (specificOpcodes includes: k) or: [ (refs includes: k) or: [conditionCodes includes: k]]]) do:
		[:k|
		Undeclared declare: k from: classPool].
	specificOpcodes withIndexDo:
		[:classVarName :value|
		self classPool
			declare: classVarName from: Undeclared;
			at: classVarName put: value + LastRTLCode - 1]