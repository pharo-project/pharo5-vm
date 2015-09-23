encoding
concreteRegister: registerIndex
	 "Map a possibly abstract register into a concrete one.  Abstract registers
	  (defined in CogAbstractOpcodes) are all negative.  If registerIndex is
	 negative assume it is an abstract register.

	[1] Figure 3.4 Register Usage in
		System V Application Binary Interface
		AMD64 Architecture Processor Supplement


	N.B. RAX RCX & RDX are caller-save (scratch) registers.  Hence we use RCX for class and RDX for
		receiver/result since these are written in all normal sends."

	^registerIndex
		caseOf: {
			[TempReg]				-> [RAX].
			[ClassReg]				-> [RCX].
			[ReceiverResultReg]	-> [RDX].
			[SendNumArgsReg]		-> [R9].
			[SPReg]					-> [RSP].
			[FPReg]					-> [RBP].
			[Arg0Reg]				-> [RSI].
			[Arg1Reg]				-> [RDI].
			[VarBaseReg]			-> [RBX]. "Must be callee saved"
			[RISCTempReg]			-> [R8].
			[Scratch0Reg]			-> [R10].
			[Scratch1Reg]			-> [R11].
			[Scratch2Reg]			-> [R12].
			[Scratch3Reg]			-> [R13].
			[Scratch4Reg]			-> [R14].
			[Scratch5Reg]			-> [R15] }
		otherwise:
			[self assert: (registerIndex between: RAX and: R15).
			 registerIndex]