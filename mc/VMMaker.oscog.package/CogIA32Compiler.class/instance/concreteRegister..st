encoding
concreteRegister: registerIndex
	 "Map a possibly abstract register into a concrete one.  Abstract registers
	  (defined in CogAbstractOpcodes) are all negative.  If registerIndex is
	 negative assume it is an abstract register.

	[1] IA-32 Intel® Architecture Software Developer's Manual Volume 2A: Instruction Set Reference, A-M


	N.B. EAX ECX & EDX are caller-save (scratch) registers.  Hence we use ECX for class and EDC for
		receiver/result since these are written in all normal sends.  EBX ESI & EDI are callee-save."

	^registerIndex
		caseOf: {
			[TempReg]				-> [EAX].
			[ClassReg]				-> [ECX].
			[ReceiverResultReg]	-> [EDX].
			[SendNumArgsReg]		-> [EBX].
			[SPReg]					-> [ESP].
			[FPReg]					-> [EBP].
			[Arg0Reg]				-> [ESI].
			[Arg1Reg]				-> [EDI] }
		otherwise:
			[self assert: (registerIndex between: EAX and: EDI).
			 registerIndex]