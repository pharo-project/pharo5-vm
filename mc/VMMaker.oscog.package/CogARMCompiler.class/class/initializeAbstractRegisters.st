class initialization
initializeAbstractRegisters
	"Assign the abstract registers with the identities/indices of the relevant concrete registers."

	"N.B. According to BSABI, R0-R3 are caller-save, R4-R12 are callee save.
	 Note that R9 might be a special register for the implementation. In some slides
	 it is refered to as sb. R10 can contain the stack limit (sl), R11 the fp. R12 is an
	 intra-procedure scratch instruction pointer for link purposes. It can also be used.
	 R10 is used as temporary inside a single abstract opcode implementation"
	"R0-R3 are used when calling back to the interpreter. Using them would require
	 saving and restoring their values, so they are omitted so far. R12 is the only
	 scratch register at the moment.."

	super initializeAbstractRegisters.

	TempReg			:= R0.
	ClassReg			:= R8.
	ReceiverResultReg	:= R7.
	SendNumArgsReg	:= R6.
	SPReg				:= SP. "a.k.a. R13" self assert: SP = 13.
	FPReg				:= R11.
	Arg0Reg			:= R4.
	Arg1Reg			:= R5.
	Extra0Reg			:= R9.
	VarBaseReg		:= R10.	"Must be callee saved" self assert: ConcreteVarBaseReg = R10.
	RISCTempReg		:= R12.	"a.k.a. IP" self assert: ConcreteIPReg = R12.
	LinkReg				:= LR. "R14"
	PCReg				:= PC. "R15"	

	DPFPReg0			:= D0.
	DPFPReg1			:= D1.
	DPFPReg2			:= D2.
	DPFPReg3			:= D3.
	DPFPReg4			:= D4.
	DPFPReg5			:= D5.
	DPFPReg6			:= D6.
	DPFPReg7			:= D7
