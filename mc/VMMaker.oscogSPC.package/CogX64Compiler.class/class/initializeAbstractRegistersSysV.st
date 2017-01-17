class initialization
initializeAbstractRegistersSysV
	"Assign the abstract registers with the identities/indices of the relevant concrete registers."
	"[1] Figure 3.4 Register Usage in
		System V Application Binary Interface
		AMD64 Architecture Processor Supplement"

	"N.B. RAX RCX & RDX are caller-save (scratch) registers.  Hence we use RCX for class and RDX for
		receiver/result since these are written in all normal sends."

	CallerSavedRegisterMask := self
									registerMaskFor: RAX
									and: RCX
									and: RDX
									and: RSI
									and: RDI
									and: R8
									and: R9
									and: R10
									and: R11.

	TempReg				:= RAX.
	ClassReg				:= RCX.
	ReceiverResultReg		:= RDX.
	SendNumArgsReg		:= R9.
	SPReg					:= RSP.
	FPReg					:= RBP.
	Arg0Reg				:= RDI. "So as to agree with C ABI arg 0"
	Arg1Reg				:= RSI. "So as to agree with C ABI arg 1"
	VarBaseReg			:= RBX. "Must be callee saved"
	"R8 is either RISCTempReg or Extra6Reg depending on subclass."
	Extra0Reg				:= R10.
	Extra1Reg				:= R11.
	Extra2Reg				:= R12.
	Extra3Reg				:= R13.
	Extra4Reg				:= R14.
	Extra5Reg				:= R15