class initialization
initializeAbstractRegistersWin64
	"Assign the abstract registers with the identities/indices of the relevant concrete registers."

	"N.B. Since receiver/result are written in all normal sends,
	it's better to use scratch registers for them (those which are caller-saved).
	In Win64 ABI, this does not let that many choices:
	- RAX is TempReg (overwritten by result etc...)
	- RCX and RDX are used for first 2 args (see genMarshallNArgs:arg:arg:arg:arg:)
	- it remains R8,R9,R10 & R11 : we choose the first two"

	CallerSavedRegisterMask := self
									registerMaskFor: RAX
									and: RCX
									and: RDX
									and: R8
									and: R9
									and: R10
									and: R11.

	TempReg				:= RAX.
	ClassReg				:= R8.
	ReceiverResultReg		:= R9.
	SendNumArgsReg		:= R10.
	SPReg					:= RSP.
	FPReg					:= RBP.
	Arg0Reg				:= RCX. "So as to agree with C ABI arg 0"
	Arg1Reg				:= RDX. "So as to agree with C ABI arg 1"
	VarBaseReg			:= RBX. "Must be callee saved"
	"R11 is either RISCTempReg or Extra6Reg depending on subclass."
	Extra0Reg				:= RDI.
	Extra1Reg				:= RSI.
	Extra2Reg				:= R12.
	Extra3Reg				:= R13.
	Extra4Reg				:= R14.
	Extra5Reg				:= R15