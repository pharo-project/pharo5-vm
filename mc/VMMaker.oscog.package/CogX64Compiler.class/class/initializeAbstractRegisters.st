class initialization
initializeAbstractRegisters
	"Assign the abstract registers with the identities/indices of the relevant concrete registers."
	"[1] Figure 3.4 Register Usage in
		System V Application Binary Interface
		AMD64 Architecture Processor Supplement

	N.B. RAX RCX & RDX are caller-save (scratch) registers.  Hence we use RCX for class and RDX for
		receiver/result since these are written in all normal sends."

	super initializeAbstractRegisters.

	TempReg				:= RAX.
	ClassReg				:= RCX.
	ReceiverResultReg		:= RDX.
	SendNumArgsReg		:= R9.
	SPReg					:= RSP.
	FPReg					:= RBP.
	Arg0Reg				:= RDI. "So as to agree with C ABI arg 0"
	Arg1Reg				:= RSI. "So as to agree with C ABI arg 1"
	VarBaseReg			:= RBX. "Must be callee saved"
	"R8 is either RISCTempReg or Scratch6Reg depending on subclass."
	Scratch0Reg			:= R10.
	Scratch1Reg			:= R11.
	Scratch2Reg			:= R12.
	Scratch3Reg			:= R13.
	Scratch4Reg			:= R14.
	Scratch5Reg			:= R15.

	DPFPReg0				:= XMM0L.
	DPFPReg1				:= XMM1L.
	DPFPReg2				:= XMM2L.
	DPFPReg3				:= XMM3L.
	DPFPReg4				:= XMM4L.
	DPFPReg5				:= XMM5L.
	DPFPReg6				:= XMM6L.
	DPFPReg7				:= XMM7L.
	DPFPReg8				:= XMM8L.
	DPFPReg9				:= XMM9L.
	DPFPReg10				:= XMM10L.
	DPFPReg11				:= XMM11L.
	DPFPReg12				:= XMM12L.
	DPFPReg13				:= XMM13L.
	DPFPReg14				:= XMM14L.
	DPFPReg15				:= XMM15L