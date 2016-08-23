class initialization
initializeAbstractRegisters
	"Assign the abstract registers with the identities/indices of the relevant concrete registers."

	"See MIPSConstants>>initializeRegisters for a description of the C ABI."

	"Note we can fit all of the abstract registers in C preserved registers, and
	 not need to save or restore them at runtime calls."
	super initializeAbstractRegisters.

	self flag: #OABI.
	CallerSavedRegisterMask := self
									registerMaskFor: T0 and: T1 and: T2 and: T3
									and: T4 and: T5 and: T6 and: T7 and: T8 and: T9.

	ReceiverResultReg		:= S0.
	Arg0Reg				:= S1.
	Arg1Reg				:= S2.
	ClassReg				:= S3.
	SendNumArgsReg		:= S4.
	TempReg				:= S5.
	VarBaseReg			:= S6. "Must be callee saved"
	SPReg					:= SP.
	FPReg					:= FP.
	RISCTempReg			:= AT.
	LinkReg					:= RA.

	self flag: #todo.
	"Extra0Reg			:= ??.
	Extra1Reg			:= ??.
	Extra2Reg			:= ??.
	Extra3Reg			:= ??.
	Extra4Reg			:= ??.
	Extra5Reg			:= ??.
	Extra6Reg			:= ??.
	Extra7Reg			:= ??."

	self flag: #todo.
	"DPFPReg0				:= ??.
	DPFPReg1				:= ??.
	DPFPReg2				:= ??.
	DPFPReg3				:= ??.
	DPFPReg4				:= ??.
	DPFPReg5				:= ??.
	DPFPReg6				:= ??.
	DPFPReg7				:= ??.
	DPFPReg8				:= ??.
	DPFPReg9				:= ??.
	DPFPReg10				:= ??.
	DPFPReg11				:= ??.
	DPFPReg12				:= ??.
	DPFPReg13				:= ??.
	DPFPReg14				:= ??.
	DPFPReg15				:= ??"