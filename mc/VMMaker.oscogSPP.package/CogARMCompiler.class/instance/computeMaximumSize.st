generate machine code
computeMaximumSize
	"Because we don't use Thumb, each ARM instruction has 4 bytes. Many
	 abstract opcodes need more than one instruction. Instructions that refer
	 to constants and/or literals depend on literals being stored in-line or out-of-line.

	 N.B.  The ^N forms are to get around the bytecode compiler's long branch
	 limits which are exceeded when each case jumps around the otherwise."

	opcode
		caseOf: {
		"Noops & Pseudo Ops"
		[Label]					-> [^0].
		[Literal]					-> [^4].
		[AlignmentNops]		-> [^(operands at: 0) - 4].
		[Fill32]					-> [^4].
		[Nop]					-> [^4].
		"Control"
		[Call]					-> [^4].
		[CallFull]				-> [^self literalLoadInstructionBytes + 4].
		[JumpR]					-> [^4].
		[Jump]					-> [^4].
		[JumpFull]				-> [^self literalLoadInstructionBytes + 4].
		[JumpLong]				-> [^4].
		[JumpZero]				-> [^4].
		[JumpNonZero]			-> [^4].
		[JumpNegative]			-> [^4].
		[JumpNonNegative]		-> [^4].
		[JumpOverflow]			-> [^4].
		[JumpNoOverflow]		-> [^4].
		[JumpCarry]			-> [^4].
		[JumpNoCarry]			-> [^4].
		[JumpLess]				-> [^4].
		[JumpGreaterOrEqual]	-> [^4].
		[JumpGreater]			-> [^4].
		[JumpLessOrEqual]		-> [^4].
		[JumpBelow]			-> [^4].
		[JumpAboveOrEqual]	-> [^4].
		[JumpAbove]			-> [^4].
		[JumpBelowOrEqual]	-> [^4].
		[JumpLongZero]		-> [^4].
		[JumpLongNonZero]	-> [^4].
		[JumpFPEqual]			-> [^8].
		[JumpFPNotEqual]		-> [^8].
		[JumpFPLess]			-> [^8].
		[JumpFPGreaterOrEqual]-> [^8].
		[JumpFPGreater]		-> [^8].
		[JumpFPLessOrEqual]	-> [^8].
		[JumpFPOrdered]		-> [^8].
		[JumpFPUnordered]		-> [^8].
		[RetN]					-> [^(operands at: 0) = 0 ifTrue: [4] ifFalse: [8]].
		[Stop]					-> [^4].

		"Arithmetic"
		[AddCqR]				-> [^self rotateable8bitSignedImmediate: (operands at: 0)
										ifTrue: [:r :i :n| 4]
										ifFalse: [self literalLoadInstructionBytes + 4]].
		[AndCqR]				-> [^self rotateable8bitBitwiseImmediate: (operands at: 0)
										ifTrue: [:r :i :n| 4]
										ifFalse:
											[self literalLoadInstructionBytes = 4
												ifTrue: [8]
												ifFalse:
													[1 << (operands at: 0) highBit = ((operands at: 0) + 1)
														ifTrue: [8]
														ifFalse: [self literalLoadInstructionBytes + 4]]]].
		[AndCqRR]				-> [^self rotateable8bitBitwiseImmediate: (operands at: 0)
										ifTrue: [:r :i :n| 4]
										ifFalse:
											[self literalLoadInstructionBytes = 4
												ifTrue: [8]
												ifFalse:
													[1 << (operands at: 0) highBit = ((operands at: 0) + 1)
														ifTrue: [8]
														ifFalse: [self literalLoadInstructionBytes + 4]]]].
		[CmpCqR]				-> [^self rotateable8bitSignedImmediate: (operands at: 0)
											ifTrue: [:r :i :n| 4]
											ifFalse: [self literalLoadInstructionBytes + 4]].
		[OrCqR]					-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| 4]
											ifFalse: [self literalLoadInstructionBytes + 4]].
		[SubCqR]				-> [^self rotateable8bitSignedImmediate: (operands at: 0)
											ifTrue: [:r :i :n| 4]
											ifFalse: [self literalLoadInstructionBytes + 4]].
		[TstCqR]				-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| 4]
											ifFalse: [self literalLoadInstructionBytes + 4]].
		[XorCqR]				-> [^self rotateable8bitBitwiseImmediate: (operands at: 0)
										ifTrue: [:r :i :n| 4]
										ifFalse:
											[self literalLoadInstructionBytes = 4
												ifTrue: [8]
												ifFalse:
													[1 << (operands at: 0) highBit = ((operands at: 0) + 1)
														ifTrue: [8]
														ifFalse: [self literalLoadInstructionBytes + 4]]]].
		[AddCwR]				-> [^self literalLoadInstructionBytes + 4].
		[AndCwR]				-> [^self literalLoadInstructionBytes + 4].
		[CmpCwR]				-> [^self literalLoadInstructionBytes + 4].
		[OrCwR]				-> [^self literalLoadInstructionBytes + 4].
		[SubCwR]				-> [^self literalLoadInstructionBytes + 4].
		[XorCwR]				-> [^self literalLoadInstructionBytes + 4].
		[AddRR]					-> [^4].
		[AndRR]					-> [^4].
		[CmpRR]				-> [^4].
		[OrRR]					-> [^4].
		[XorRR]					-> [^4].
		[SubRR]					-> [^4].
		[NegateR]				-> [^4].
		[LoadEffectiveAddressMwrR]
									-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| 4]
											ifFalse: [self literalLoadInstructionBytes + 4]].

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
		"ARM Specific Arithmetic"
		[SMULL]				-> [^4].
		[MSR]					-> [^4].
		[CMPSMULL]			-> [^4]. "special compare for genMulR:R: usage"
		"ARM Specific Data Movement"
		[PopLDM]				-> [^4].
		[PushSTM]				-> [^4].
		"Data Movement"						
		[MoveCqR]				-> [^self literalLoadInstructionBytes = 4
										ifTrue: [self literalLoadInstructionBytes]
										ifFalse:
											[self rotateable8bitBitwiseImmediate: (operands at: 0)
												ifTrue: [:r :i :n| 4]
												ifFalse: [self literalLoadInstructionBytes]]].
		[MoveCwR]				-> [^self literalLoadInstructionBytes = 4
										ifTrue: [self literalLoadInstructionBytes]
										ifFalse:
											[(self inCurrentCompilation: (operands at: 0))
												ifTrue: [4]
												ifFalse: [self literalLoadInstructionBytes]]].
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
		[MoveRMwr]			-> [^self is12BitValue: (operands at: 1)
										ifTrue: [:u :i| 4]
										ifFalse: [self literalLoadInstructionBytes + 4]].
		[MoveRdM64r]			-> [^self literalLoadInstructionBytes + 4]. 
		[MoveMbrR]				-> [^self is12BitValue: (operands at: 0)
										ifTrue: [:u :i| 4]
										ifFalse: [self literalLoadInstructionBytes + 4]].
		[MoveRMbr]				-> [^self is12BitValue: (operands at: 1)
										ifTrue: [:u :i| 4]
										ifFalse: [self literalLoadInstructionBytes + 4]].
		[MoveRM16r]				-> [^self is12BitValue: (operands at: 1)
										ifTrue: [:u :i| 4]
										ifFalse: [self literalLoadInstructionBytes + 4]].
		[MoveM16rR]			-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| 4]
											ifFalse: [self literalLoadInstructionBytes + 4]].
		[MoveM64rRd]			-> [^self literalLoadInstructionBytes + 4].
		[MoveMwrR]			-> [^self is12BitValue: (operands at: 0)
										ifTrue: [:u :i| 4]
										ifFalse: [self literalLoadInstructionBytes + 4]].
		[MoveXbrRR]			-> [^4].
		[MoveRXbrR]			-> [^4].
		[MoveXwrRR]			-> [^4].
		[MoveRXwrR]			-> [^4].
		[PopR]					-> [^4].
		[PushR]					-> [^4].
		[PushCw]				-> [^self literalLoadInstructionBytes = 4
										ifTrue: [self literalLoadInstructionBytes + 4]
										ifFalse:
											[(self inCurrentCompilation: (operands at: 0))
												ifTrue: [8]
												ifFalse:
													[self rotateable8bitBitwiseImmediate: (operands at: 0)
														ifTrue: [:r :i :n| 8]
														ifFalse: [self literalLoadInstructionBytes + 4]]]].
		[PushCq]				-> [^self literalLoadInstructionBytes = 4
										ifTrue: [self literalLoadInstructionBytes + 4]
										ifFalse:
											[self rotateable8bitBitwiseImmediate: (operands at: 0)
												ifTrue: [:r :i :n| 8]
												ifFalse: [self literalLoadInstructionBytes + 4]]].
		[PrefetchAw] 			-> [^(self isAddressRelativeToVarBase: (operands at: 0))
										ifTrue: [4]
										ifFalse: [self literalLoadInstructionBytes + 4]].
		"Conversion"
		[ConvertRRd]			-> [^8].
		}.
	^0 "to keep C compiler quiet"
