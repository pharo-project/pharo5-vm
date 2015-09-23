encoding
concreteRegister: registerIndex
	 "Map a possibly abstract register into a concrete one.  Abstract registers
	  (defined in CogAbstractOpcodes) are all negative.  If registerIndex is
	  negative assume it is an abstract register."
	
	"N.B. According to BSABI, R0-R3 are caller-save, R4-R12 are callee save.
	 Note that R9 might be a special register for the implementation. In some slides
	 it is refered to as sb. R10 can contain the stack limit (sl), R11 the fp. R12 is an
	 intra-procedure scratch instruction pointer for link purposes. It can also be used.
	 R10 is used as temporary inside a single abstract opcode implementation"
	"R0-R3 are used when calling back to the interpreter. Using them would require
	 saving and restoring their values, so they are omitted so far. R12 is the only
	 scratch register at the moment.."
	^registerIndex
		caseOf: {
			[TempReg]				-> [R0].
			[ClassReg]				-> [R8].
			[ReceiverResultReg]	-> [R7].
			[SendNumArgsReg]		-> [R6].
			[SPReg]					-> [SP]. "R13"
			[FPReg]					-> [R11].
			[Arg0Reg]				-> [R4].
			[Arg1Reg]				-> [R5].
			[VarBaseReg]			-> [ConcreteVarBaseReg]. "Must be callee saved"
			[RISCTempReg]			-> [ConcreteIPReg]. "a.k.a. IP"
			[Scratch0Reg]			-> [R12].
			[LinkReg]				-> [LR]. "R14"
			[PCReg]					-> [PC] "R15" }
		otherwise:
			[self assert: (registerIndex between: R0 and: PC).
			 registerIndex]