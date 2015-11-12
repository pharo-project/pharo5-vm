encoding
concreteRegister: registerIndex
	"Map a possibly abstract register into a concrete one.  Abstract registers
	 (defined in CogAbstractOpcodes) are all negative.  If registerIndex is
	 negative assume it is an abstract register."
	
	"See MIPSConstants>>initializeRegisters for a description of the C ABI."

	"Note we can fit all of the abstract registers in C preserved registers, and
	 not need to save or restore them at runtime calls."
	
	^registerIndex
		caseOf: {
			[ReceiverResultReg]	-> [S0].
			[Arg0Reg]				-> [S1].
			[Arg1Reg]				-> [S2].
			[ClassReg]				-> [S3].
			[SendNumArgsReg]		-> [S4].
			[TempReg]				-> [S5].
			[VarBaseReg]			-> [S6]. "Must be callee saved"
			[SPReg]					-> [SP].
			[FPReg]					-> [FP].
			[RISCTempReg]			-> [AT].
			[LinkReg]				-> [RA]. }
		otherwise:
			[self assert: (registerIndex between: R0 and: R31).
			 registerIndex]