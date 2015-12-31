class initialization
initializeAbstractRegisters
	"Assign the abstract registers with the identities/indices of the relevant concrete registers."

	"See MIPSConstants>>initializeRegisters for a description of the C ABI."

	"Note we can fit all of the abstract registers in C preserved registers, and
	 not need to save or restore them at runtime calls."
	super initializeAbstractRegisters.

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
	Scratch0Reg			:= NoReg.
	Scratch1Reg			:= NoReg.
	Scratch2Reg			:= NoReg.
	Scratch3Reg			:= NoReg.
	Scratch4Reg			:= NoReg.
	Scratch5Reg			:= NoReg.
	Scratch6Reg			:= NoReg.
	Scratch7Reg			:= NoReg.

	self flag: #todo.
	DPFPReg0				:= NoReg.
	DPFPReg1				:= NoReg.
	DPFPReg2				:= NoReg.
	DPFPReg3				:= NoReg.
	DPFPReg4				:= NoReg.
	DPFPReg5				:= NoReg.
	DPFPReg6				:= NoReg.
	DPFPReg7				:= NoReg.
	DPFPReg8				:= NoReg.
	DPFPReg9				:= NoReg.
	DPFPReg10				:= NoReg.
	DPFPReg11				:= NoReg.
	DPFPReg12				:= NoReg.
	DPFPReg13				:= NoReg.
	DPFPReg14				:= NoReg.
	DPFPReg15				:= NoReg.
					
