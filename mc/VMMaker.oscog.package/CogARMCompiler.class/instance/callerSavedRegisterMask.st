accessing
callerSavedRegisterMask
	"According to IHI0042E ARM Architecture Procedure Calling Standard, in section 5.1.1:
		A subroutine must preserve the contents of the registers r4-r8, r10, r11 and SP (and r9 in PCS variants that designate r9 as v6).
	 SP = r13, so the callee-saved regs are r4-r8 & r10-r12.
	 The caller-saved registers are those that are not callee-saved and not reserved for hardware/abi uses,
	 i..e r0-r3, r9 & r12.  We can't name all the C argument registers.  So..."
	^cogit
		registerMaskFor: (self abstractRegisterForConcreteRegister: 0)
		"and: (self abstractRegisterForConcreteRegister: 1)"
		"and: (self abstractRegisterForConcreteRegister: 2)"
		"and: (self abstractRegisterForConcreteRegister: 3)"
		"and: (self abstractRegisterForConcreteRegister: 9)"
		and: (self abstractRegisterForConcreteRegister: 12)