class initialization
initializeAbstractRegisters
	"Assign the abstract registers with the identities/indices of the relevant concrete registers."

	super initializeAbstractRegisters.

	"N.B. EAX ECX & EDX are caller-save (scratch) registers.  Hence we use ECX for class and EDX for
		receiver/result since these are written in all normal sends.  EBX ESI & EDI are callee-save."

	CallerSavedRegisterMask := self registerMaskFor: EAX and: ECX and: EDX.

	TempReg				:= EAX.
	ClassReg				:= ECX.
	ReceiverResultReg		:= EDX.
	SendNumArgsReg		:= EBX.
	SPReg					:= ESP.
	FPReg					:= EBP.
	Arg0Reg				:= ESI.
	Arg1Reg				:= EDI.

	DPFPReg0				:= XMM0L.
	DPFPReg1				:= XMM1L.
	DPFPReg2				:= XMM2L.
	DPFPReg3				:= XMM3L.
	DPFPReg4				:= XMM4L.
	DPFPReg5				:= XMM5L.
	DPFPReg6				:= XMM6L.
	DPFPReg7				:= XMM7L