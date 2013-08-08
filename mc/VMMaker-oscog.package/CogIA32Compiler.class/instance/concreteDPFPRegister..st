encoding
concreteDPFPRegister: registerIndex
	 "Map a possibly abstract double-precision floating-point register into a concrete one.
	  Abstract registers (defined in CogAbstractOpcodes) are all negative.  If registerIndex
	  is negative assume it is an abstract register.

	[1] IA-32 Intel® Architecture Software Developer's Manual Volume 2A: Instruction Set Reference, A-M"

	^registerIndex
		caseOf: {
			[DPFPReg0]	-> [XMM0L / 2].
			[DPFPReg1]	-> [XMM1L / 2].
			[DPFPReg2]	-> [XMM2L / 2].
			[DPFPReg3]	-> [XMM3L / 2].
			[DPFPReg4]	-> [XMM4L / 2].
			[DPFPReg5]	-> [XMM5L / 2].
			[DPFPReg6]	-> [XMM6L / 2].
			[DPFPReg7]	-> [XMM7L / 2] }
		otherwise:
			[self assert: (registerIndex between: XMM0L and: XMM7L).
			 self assert: (registerIndex bitAnd: 1) = 0.
			 registerIndex / 2]