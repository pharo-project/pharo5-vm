class initialization
initialize
	"Initialize various x64 instruction-related constants.
	 [1] IA-32 Intel® Architecture Software Developer's Manual Volume 2A: Instruction Set Reference, A-M"

	"CogX64Compiler initialize"

	| specificOpcodes refs |
	self ~~ CogX64Compiler ifTrue: [^self].

	RAX := 0.
	RCX := 1.  "Were they completely mad or simply sadistic?"
	RDX := 2.
	RBX := 3.
	RSP := 4.
	RBP := 5.
	RSI := 6.
	RDI := 7.
	R8 := 8.
	R9 := 9.
	R10 := 10.
	R11 := 11.
	R12 := 12.
	R13 := 13.
	R14 := 14.
	R15 := 15.

	XMM0L := 0.
	XMM1L := 2.
	XMM2L := 4.
	XMM3L := 6.
	XMM4L := 8.
	XMM5L := 10.
	XMM6L := 12.
	XMM7L := 14.

	XMM0H := 1.
	XMM1H := 3.
	XMM2H := 5.
	XMM3H := 7.
	XMM4H := 9.
	XMM5H := 11.
	XMM6H := 13.
	XMM7H := 15.

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
	LastRTLCode ifNil:
		[CogRTLOpcodes initialize].
	specificOpcodes := #(CDQ IDIVR IMULRR CPUID LFENCE MFENCE SFENCE LOCK CMPXCHGAwR CMPXCHGMwrR XCHGAwR XCHGMwrR XCHGRR).
	refs := (thisContext method literals select: [:l| l isVariableBinding and: [classPool includesKey: l key]]) collect:
				[:ea| ea key].
	(classPool keys reject: [:k| (specificOpcodes includes: k) or: [refs includes: k]]) do:
		[:k|
		Undeclared declare: k from: classPool].
	specificOpcodes withIndexDo:
		[:classVarName :value|
		self classPool
			declare: classVarName from: Undeclared;
			at: classVarName put: value + LastRTLCode - 1]