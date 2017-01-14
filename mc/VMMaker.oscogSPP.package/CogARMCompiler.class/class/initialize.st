class initialization
initialize

	"Initialize various ARM instruction-related constants."
	"CogARMCompiler initialize"

	super initialize.
	self ~~ CogARMCompiler ifTrue: [^self].

	"ARM general registers"
	R0 := 0.
	R1 := 1.
	R2 := 2.
	R3 := 3.
	R4 := 4.
	R5 := 5.
	R6 := 6.
	R7 := 7.
	R8 := 8.
	R9 := 9.
	R10 := 10.
	R11 := 11.
	R12 := 12.
	SP := 13.
	LR := 14.
	PC := 15.
	"ARM VFP Double precision floating point registers"
	D0 := 0.
	D1 := 1.
	D2 := 2.
	D3 := 3.
	D4 := 4.
	D5 := 5.
	D6 := 6.
	D7 := 7.

	CArg0Reg := 0.
	CArg1Reg := 1.
	CArg2Reg := 2.
	CArg3Reg := 3.

	ConcreteVarBaseReg := 10.
	ConcreteIPReg := 12. "IP, The Intra-Procedure-call scratch register."
	ConcretePCReg := 15.

	"Condition Codes. Note that cc=16rF is NOT ALLOWED as a condition; it specifies an extension instruction. See e.g.ARM_ARM v5 DDI01001.pdf A3.2.1"
	EQ := 0.
	NE := 1.
	CS := 2.
	CC := 3.
	MI := 4.
	PL := 5.
	VS := 6.
	VC := 7.
	HI := 8.
	LS := 9.
	GE := 10.
	LT := 11.
	GT := 12.
	LE := 13.
	AL := 14.

	"Table A3-2 in sec A3.4 Data-processing instructions of the AARM."
	AddOpcode := 	4.
	AndOpcode := 0.
	BicOpcode := 14.
	CmpOpcode := 10.
	CmpNotOpcode := 11.
	MoveOpcode := 13.
	MoveNotOpcode := 15.
	OrOpcode := 12.
	RsbOpcode := 3.
	SMLALOpcode := 7.
	SubOpcode := 2.
	TstOpcode := 8.
	XorOpcode := 1.

	CPSRReg := 16.
	OverflowFlag := 1 << 28.

	"Specific instructions"
	self
		initializeSpecificOpcodes: #(SMULL MSR MRS PopLDM PushSTM LDMFD STMFD CMPSMULL)
		in: thisContext method