generate machine code
computeMaximumSize
	"Each MIPS instruction has 4 bytes. Many abstract opcodes need more than one
	 instruction. Instructions that refer to constants and/or literals depend on literals
	 being stored in-line or out-of-line.

	 N.B.  The ^N forms are to get around the bytecode compiler's long branch
	 limits which are exceeded when each case jumps around the otherwise."

	opcode
		caseOf: {
		[BrEqualRR]						-> [^8].
		[BrNotEqualRR]					-> [^8].
		[BrUnsignedLessRR]			-> [^12].
		[BrUnsignedLessEqualRR]		-> [^12].
		[BrUnsignedGreaterRR]			-> [^12].
		[BrUnsignedGreaterEqualRR]	-> [^12].
		[BrSignedLessRR]				-> [^12].
		[BrSignedLessEqualRR]			-> [^12].
		[BrSignedGreaterRR]			-> [^12].
		[BrSignedGreaterEqualRR]		-> [^12].
		[BrLongEqualRR]				-> [^16].
		[BrLongNotEqualRR]				-> [^16].
		[MulRR]					-> [^4].
		[DivRR]					-> [^4].
		[MoveLowR]			-> [^4].
		[MoveHighR]			-> [^4].

		"Noops & Pseudo Ops"
		[Label]					-> [^0].
		[Literal]					-> [^4].
		[AlignmentNops]		-> [^(operands at: 0) - 4].
		[Fill32]					-> [^4].
		[Nop]					-> [^4].
		"Control"
		[Call]					-> [^self literalLoadInstructionBytes + 8].
		[CallFull]				-> [^self literalLoadInstructionBytes + 8].
		[JumpR]					-> [^8].
		[Jump]					-> [^8].
		[JumpFull]				-> [^self literalLoadInstructionBytes + 8].
		[JumpLong]				-> [^self literalLoadInstructionBytes + 8].
		[JumpZero]				-> [^8].
		[JumpNonZero]			-> [^8].
		[JumpNegative]			-> [^8].
		[JumpNonNegative]		-> [^8].
		[JumpOverflow]			-> [^8].
		[JumpNoOverflow]		-> [^8].
		[JumpCarry]			-> [^8].
		[JumpNoCarry]			-> [^8].
		[JumpLess]				-> [^8].
		[JumpGreaterOrEqual]	-> [^8].
		[JumpGreater]			-> [^8].
		[JumpLessOrEqual]		-> [^8].
		[JumpBelow]			-> [^8].
		[JumpAboveOrEqual]	-> [^8].
		[JumpAbove]			-> [^8].
		[JumpBelowOrEqual]	-> [^8].
		[JumpLongZero]		-> [^self literalLoadInstructionBytes + 8].
		[JumpLongNonZero]	-> [^self literalLoadInstructionBytes + 8].
		[JumpFPEqual]			-> [^8].
		[JumpFPNotEqual]		-> [^8].
		[JumpFPLess]			-> [^8].
		[JumpFPGreaterOrEqual]-> [^8].
		[JumpFPGreater]		-> [^8].
		[JumpFPLessOrEqual]	-> [^8].
		[JumpFPOrdered]		-> [^8].
		[JumpFPUnordered]		-> [^8].
		[RetN]					-> [^8].
		[Stop]					-> [^4].

		"Arithmetic"
		[AddCqR]				-> [^12].
		[AndCqR]				-> [^16].
		[AndCqRR]				-> [^12].
		[CmpCqR]				-> [^28].
		[OrCqR]					-> [^12].
		[SubCqR]				-> [^12].
		[TstCqR]				-> [^12].
		[XorCqR]				-> [^12].
		[AddCwR]				-> [^12].
		[AndCwR]				-> [^12].
		[CmpCwR]				-> [^28].
		[OrCwR]				-> [^12].
		[SubCwR]				-> [^12].
		[XorCwR]				-> [^12].
		[AddRR]					-> [^4].
		[AndRR]					-> [^4].
		[CmpRR]				-> [^20].
		[OrRR]					-> [^4].
		[XorRR]					-> [^4].
		[SubRR]					-> [^4].
		[NegateR]				-> [^4].
		[LoadEffectiveAddressMwrR] -> [^12].
		[LogicalShiftLeftCqR]		-> [^4].
		[LogicalShiftRightCqR]		-> [^4].
		[ArithmeticShiftRightCqR]	-> [^4].
		[LogicalShiftLeftRR]			-> [^4].
		[LogicalShiftRightRR]		-> [^4].
		[ArithmeticShiftRightRR]		-> [^4].
		[AddRdRd]					-> [^4].
		[CmpRdRd]					-> [^4].
		[SubRdRd]					-> [^4].
		[MulRdRd]					-> [^4].
		[DivRdRd]					-> [^4].
		[SqrtRd]					-> [^4].
		[AddCheckOverflowCqR]	-> [^28].
		[AddCheckOverflowRR]		-> [^20].
		[SubCheckOverflowCqR]	-> [^28].
		[SubCheckOverflowRR]		-> [^20].
		[MulCheckOverflowRR]		-> [^20].
		"Data Movement"						
		[MoveCqR]				-> [^8 "or 4"].
		[MoveCwR]				-> [^8].
		[MoveRR]				-> [^4].
		[MoveRdRd]				-> [^4].
		[MoveAwR]				-> [^(self isAddressRelativeToVarBase: (operands at: 0))
													ifTrue: [4]
													ifFalse: [self literalLoadInstructionBytes + 4]].
		[MoveRAw]				-> [^(self isAddressRelativeToVarBase: (operands at: 1))
													ifTrue: [4]
													ifFalse: [self literalLoadInstructionBytes + 4]].
		[MoveAbR]				-> [^(self isAddressRelativeToVarBase: (operands at: 0))
													ifTrue: [4]
													ifFalse: [self literalLoadInstructionBytes + 4]].
		[MoveRAb]				-> [^(self isAddressRelativeToVarBase: (operands at: 1))
													ifTrue: [4]
													ifFalse: [self literalLoadInstructionBytes + 4]].
		[MoveRMwr]			-> [^16].
		[MoveRdM64r]			-> [^self literalLoadInstructionBytes + 4]. 
		[MoveMbrR]				-> [^4].
		[MoveRMbr]				-> [^4].
		[MoveM16rR]			-> [^4].
		[MoveRM16r]			-> [^4].
		[MoveM64rRd]			-> [^self literalLoadInstructionBytes + 4].
		[MoveMwrR]			-> [^16].
		[MoveXbrRR]			-> [^8].
		[MoveRXbrR]			-> [^8].
		[MoveXwrRR]			-> [^12].
		[MoveRXwrR]			-> [^12].
		[PopR]					-> [^8].
		[PushR]					-> [^8].
		[PushCw]				-> [^16].
		[PushCq]				-> [^16].
		[PrefetchAw] 			-> [^12].
		"Conversion"
		[ConvertRRd]			-> [^8].
		}.
	^0 "to keep C compiler quiet"
