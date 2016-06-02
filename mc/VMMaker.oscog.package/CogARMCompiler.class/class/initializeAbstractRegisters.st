class initialization
initializeAbstractRegisters
	"Assign the abstract registers with the identities/indices of the relevant concrete registers."

	super initializeAbstractRegisters.

	"According to IHI0042E ARM Architecture Procedure Calling Standard, in section 5.1.1:
		A subroutine must preserve the contents of the registers r4-r8, r10, r11 and SP (and r9 in PCS variants that designate r9 as v6).
	 SP = r13, so the callee-saved regs are r4-r8 & r10-r12.
	 The caller-saved registers are those that are not callee-saved and not reserved for hardware/abi uses,
	 i..e r0-r3, r9 & r12.
	 We exclude registers 0 & 1 (TempReg/CArg0Reg & CArg1Reg) from the CallerSavedRegisterMask because we only
	 use them for argument passing and so never want to save and restore them.  In fact restoring TempReg/CArg0Reg
	 would overwrite function results, so it shouldn't be included under any circumstances."

	CallerSavedRegisterMask := self registerMaskFor: "0 and: 1 and:" 2 and: 3 and: 9 and: 12.

	TempReg			:= R0.
	ClassReg			:= R2.
	ReceiverResultReg	:= R5.
	SendNumArgsReg	:= R6.
	SPReg				:= SP. "a.k.a. R13" self assert: SP = 13.
	FPReg				:= R11.
	Arg0Reg			:= R3. "overlaps with last C arg reg"
	Arg1Reg			:= R4.
	Extra0Reg			:= R7.
	Extra1Reg			:= R8.
	Extra2Reg			:= R9.
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