class initialization
initialize
	"Initialize various IA32/x86 instruction-related constants.
	 [1] IA-32 Intel® Architecture Software Developer's Manual Volume 2A: Instruction Set Reference, A-M"

	"CogIA32Compiler initialize"

	self ~~ CogIA32Compiler ifTrue: [^self].

	"N.B. EAX ECX and EDX are caller-save (scratch) registers.
		EBX ESI and EDI are callee-save; see concreteRegisterFor:"
	EAX := 0.
	ECX := 1.  "Were they completely mad or simply sadistic?"
	EDX := 2.
	EBX := 3.
	ESP := 4.
	EBP := 5.
	ESI := 6.
	EDI := 7.

	XMM0L := 0.
	XMM1L := 1.
	XMM2L := 2.
	XMM3L := 3.
	XMM4L := 4.
	XMM5L := 5.
	XMM6L := 6.
	XMM7L := 7.

	"Mod R/M Mod fields.  See [1] Sec 2.4, 2.5 & 2.6 & Table 2-2"
	ModRegInd := 0.
		ModRegIndSIB := 4.
		ModRegIndDisp32 := 5.
	ModRegRegDisp8 := 1.
	ModRegRegDisp32 := 2.
	ModReg := 3.

	"SIB Scaled Index modes.  See [1] Sec 2.4, 2.5 & 2.6 & Table 2-3"
	SIB1 := 0.
	SIB2 := 1.
	SIB4 := 2.
	SIB8 := 3.

	"Specific instructions"
	self
		initializeSpecificOpcodes: #(CDQ IDIVR IMULRR CPUID LFENCE MFENCE SFENCE LOCK CMPXCHGAwR CMPXCHGMwrR XCHGAwR XCHGMwrR XCHGRR FSTPS FSTPD CLD REP MOVSB MOVSD)
		in: thisContext method