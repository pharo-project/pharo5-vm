class initialization
initializeAbstractRegisters
	"Assign the abstract registers with the identities/indices of the relevant concrete registers."

	"N.B. EAX ECX & EDX are caller-save (scratch) registers.  Hence we use ECX for class and EDX for
		receiver/result since these are written in all normal sends.  EBX ESI & EDI are callee-save."

	TempReg				:= EAX.
	ClassReg				:= ECX.
	ReceiverResultReg		:= EDX.
	SendNumArgsReg		:= EBX.
	SPReg					:= ESP.
	FPReg					:= EBP.
	Arg0Reg				:= ESI.
	Arg1Reg				:= EDI.

	DPFPReg0				:= XMM0L / 2.
	DPFPReg1				:= XMM1L / 2.
	DPFPReg2				:= XMM2L / 2.
	DPFPReg3				:= XMM3L / 2.
	DPFPReg4				:= XMM4L / 2.
	DPFPReg5				:= XMM5L / 2.
	DPFPReg6				:= XMM6L / 2.
	DPFPReg7				:= XMM7L / 2