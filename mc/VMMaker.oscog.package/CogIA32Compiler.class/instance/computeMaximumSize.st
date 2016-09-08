generate machine code
computeMaximumSize
	"Compute the maximum size for each opcode.  This allows jump offsets to
	 be determined, provided that all backward branches are long branches."
	"N.B.  The ^N forms are to get around the bytecode compiler's long branch
	 limits which are exceeded when each case jumps around the otherwise."
	opcode caseOf: {
		"Noops & Pseudo Ops"
		[Label]					-> [^0].
		[AlignmentNops]		-> [^(operands at: 0) - 1].
		[Fill32]					-> [^4].
		[Nop]					-> [^1].
		"Specific Control/Data Movement"
		[REP]					-> [^1].
		[CLD]					-> [^1].
		[MOVSB]				-> [^1].
		[MOVSD]				-> [^1].
		[CDQ]					-> [^1].
		[IDIVR]					-> [^2].
		[IMULRR]				-> [^3].
		[CPUID]					-> [^2].
		[CMPXCHGAwR]			-> [^7].
		[CMPXCHGMwrR]		-> [^(operands at: 1) = ESP
										ifTrue: [(self isQuick: (operands at: 0)) ifTrue: [5] ifFalse: [8]]
										ifFalse: [(self isQuick: (operands at: 0)) ifTrue: [4] ifFalse: [7]]].
		[LFENCE]				-> [^3].
		[MFENCE]				-> [^3].
		[SFENCE]				-> [^3].
		[LOCK]					-> [^1].
		[XCHGAwR]				-> [^6].
		[XCHGMwrR]			-> [^(operands at: 1) = ESP
										ifTrue: [(self isQuick: (operands at: 0)) ifTrue: [4] ifFalse: [7]]
										ifFalse: [(self isQuick: (operands at: 0)) ifTrue: [3] ifFalse: [6]]].
		[XCHGRR]				-> [^((operands at: 0) = EAX
									   or: [(operands at: 1) = EAX])
										ifTrue: [1]
										ifFalse: [2]].
		[FSTPS]					-> [^7].
		[FSTPD]					-> [^7].
						
		"Control"
		[CallFull]					-> [^5].
		[Call]						-> [^5].
		[CallR]					-> [^2].
		[JumpR]						-> [^2].
		[JumpFull]					-> [self resolveJumpTarget. ^5].
		[JumpLong]					-> [self resolveJumpTarget. ^5].
		[Jump]						-> [self resolveJumpTarget. ^5].
		[JumpZero]					-> [self resolveJumpTarget. ^6].
		[JumpNonZero]				-> [self resolveJumpTarget. ^6].
		[JumpNegative]				-> [self resolveJumpTarget. ^6].
		[JumpNonNegative]			-> [self resolveJumpTarget. ^6].
		[JumpOverflow]				-> [self resolveJumpTarget. ^6].
		[JumpNoOverflow]			-> [self resolveJumpTarget. ^6].
		[JumpCarry]				-> [self resolveJumpTarget. ^6].
		[JumpNoCarry]				-> [self resolveJumpTarget. ^6].
		[JumpLess]					-> [self resolveJumpTarget. ^6].
		[JumpGreaterOrEqual]		-> [self resolveJumpTarget. ^6].
		[JumpGreater]				-> [self resolveJumpTarget. ^6].
		[JumpLessOrEqual]			-> [self resolveJumpTarget. ^6].
		[JumpBelow]				-> [self resolveJumpTarget. ^6].
		[JumpAboveOrEqual]		-> [self resolveJumpTarget. ^6].
		[JumpAbove]				-> [self resolveJumpTarget. ^6].
		[JumpBelowOrEqual]		-> [self resolveJumpTarget. ^6].
		[JumpLongZero]			-> [self resolveJumpTarget. ^6].
		[JumpLongNonZero]		-> [self resolveJumpTarget. ^6].
		[JumpFPEqual]				-> [self resolveJumpTarget. ^6].
		[JumpFPNotEqual]			-> [self resolveJumpTarget. ^6].
		[JumpFPLess]				-> [self resolveJumpTarget. ^6].
		[JumpFPGreaterOrEqual]	-> [self resolveJumpTarget. ^6].
		[JumpFPGreater]			-> [self resolveJumpTarget. ^6].
		[JumpFPLessOrEqual]		-> [self resolveJumpTarget. ^6].
		[JumpFPOrdered]			-> [self resolveJumpTarget. ^6].
		[JumpFPUnordered]			-> [self resolveJumpTarget. ^6].
		[RetN]						-> [^(operands at: 0) = 0 ifTrue: [1] ifFalse: [3]].
		[Stop]						-> [^1].

		"Arithmetic"
		[AddCqR]		-> [^(self isQuick: (operands at: 0))
											ifTrue: [3]
											ifFalse: [(operands at: 1) = EAX
														ifTrue: [5]
														ifFalse: [6]]].
		[AddcCqR]		-> [^(self isQuick: (operands at: 0))
											ifTrue: [3]
											ifFalse: [(operands at: 1) = EAX
														ifTrue: [5]
														ifFalse: [6]]].
		[AndCqR]		-> [^(self isQuick: (operands at: 0))
											ifTrue: [3]
											ifFalse: [(operands at: 1) = EAX
														ifTrue: [5]
														ifFalse: [6]]].
		[CmpCqR]		-> [^(self isQuick: (operands at: 0))
											ifTrue: [3]
											ifFalse: [(operands at: 1) = EAX
														ifTrue: [5]
														ifFalse: [6]]].
		[OrCqR]			-> [^(self isQuick: (operands at: 0))
											ifTrue: [3]
											ifFalse: [(operands at: 1) = EAX
														ifTrue: [5]
														ifFalse: [6]]].
		[SubCqR]		-> [^(self isQuick: (operands at: 0))
											ifTrue: [3]
											ifFalse: [(operands at: 1) = EAX
														ifTrue: [5]
														ifFalse: [6]]].
		[TstCqR]		-> [^((self isQuick: (operands at: 0)) and: [(operands at: 1) < 4])
											ifTrue: [3]
											ifFalse: [(operands at: 1) = EAX
														ifTrue: [5]
														ifFalse: [6]]].
		[AddCwR]		-> [^(operands at: 1) = EAX ifTrue: [5] ifFalse: [6]].
		[AndCwR]		-> [^(operands at: 1) = EAX ifTrue: [5] ifFalse: [6]].
		[CmpCwR]		-> [^(operands at: 1) = EAX ifTrue: [5] ifFalse: [6]].
		[OrCwR]		-> [^(operands at: 1) = EAX ifTrue: [5] ifFalse: [6]].
		[SubCwR]		-> [^(operands at: 1) = EAX ifTrue: [5] ifFalse: [6]].
		[XorCwR]		-> [^(operands at: 1) = EAX ifTrue: [5] ifFalse: [6]].
		[AddRR]			-> [^2].
		[AndRR]			-> [^2].
		[CmpRR]		-> [^2].
		[OrRR]			-> [^2].
		[XorRR]			-> [^2].
		[SubRR]			-> [^2].
		[NegateR]		-> [^2].
		[NotR]		-> [^2].
		[LoadEffectiveAddressMwrR]
						-> [^((self isQuick: (operands at: 0))
											ifTrue: [3]
											ifFalse: [6])
										+ ((operands at: 1) = ESP
											ifTrue: [1]
											ifFalse: [0])].
		[LogicalShiftLeftCqR]		-> [^(operands at: 0) = 1 ifTrue: [2] ifFalse: [3]].
		[LogicalShiftRightCqR]		-> [^(operands at: 0) = 1 ifTrue: [2] ifFalse: [3]].
		[ArithmeticShiftRightCqR]	-> [^(operands at: 0) = 1 ifTrue: [2] ifFalse: [3]].
		[LogicalShiftLeftRR]			-> [^self computeShiftRRSize].
		[LogicalShiftRightRR]		-> [^self computeShiftRRSize].
		[ArithmeticShiftRightRR]		-> [^self computeShiftRRSize].
		[AddRdRd]					-> [^4].
		[CmpRdRd]					-> [^4].
		[SubRdRd]					-> [^4].
		[MulRdRd]					-> [^4].
		[DivRdRd]					-> [^4].
		[SqrtRd]					-> [^4].
		[XorRdRd]					-> [^4].
						
		[AddRsRs]				-> [^4].
		[CmpRsRs]				-> [^3].
		[SubRsRs]				-> [^4].
		[MulRsRs]				-> [^4].
		[DivRsRs]				-> [^4].
		[SqrtRs]					-> [^4].
		[XorRsRs]					-> [^3].
						
		"Data Movement"
		[MoveCqR]		-> [^(operands at: 0) = 0 ifTrue: [2] ifFalse: [5]].
		[MoveCwR]		-> [^5].
		[MoveRR]		-> [^2].
		[MoveRdRd]		-> [^4].
		[MoveRsRs]		-> [^4].
		[MoveAwR]		-> [^(operands at: 1) = EAX ifTrue: [5] ifFalse: [6]].
		[MoveRAw]		-> [^(operands at: 0) = EAX ifTrue: [5] ifFalse: [6]].
		[MoveAbR]		-> [^7].
		[MoveRAb]		-> [^(operands at: 0) = EAX ifTrue: [5] ifFalse: [6]].
		[MoveRM32r]	-> [^((self isQuick: (operands at: 1))
									ifTrue: [((operands at: 1) = 0
											and: [(operands at: 2) ~= EBP])
												ifTrue: [2]
												ifFalse: [3]]
									ifFalse: [6])
								+ ((operands at: 2) = ESP
									ifTrue: [1]
									ifFalse: [0])].
		[MoveRMwr]	-> [^((self isQuick: (operands at: 1))
									ifTrue: [((operands at: 1) = 0
											and: [(operands at: 2) ~= EBP])
												ifTrue: [2]
												ifFalse: [3]]
									ifFalse: [6])
								+ ((operands at: 2) = ESP
									ifTrue: [1]
									ifFalse: [0])].
		[MoveRdM64r]	-> [^((self isQuick: (operands at: 1))
											ifTrue: [5]
											ifFalse: [8])
										+ ((operands at: 2) = ESP
											ifTrue: [1]
											ifFalse: [0])].
		[MoveRsM32r]	-> [^((self isQuick: (operands at: 1))
											ifTrue: [5]
											ifFalse: [8])
										+ ((operands at: 2) = ESP
											ifTrue: [1]
											ifFalse: [0])].
		[MoveMbrR]		-> [^(operands at: 1) = ESP
								ifTrue: [(self isQuick: (operands at: 0)) ifTrue: [5] ifFalse: [8]]
								ifFalse: [(self isQuick: (operands at: 0)) ifTrue: [4] ifFalse: [7]]].
		[MoveRMbr]		-> [^(operands at: 2) = ESP
								ifTrue: [7]
								ifFalse: [(self isQuick: (operands at: 1)) ifTrue: [3] ifFalse: [6]]].
		[MoveM8rR]		-> [^(operands at: 1) = ESP
								ifTrue: [(self isQuick: (operands at: 0)) ifTrue: [5] ifFalse: [8]]
								ifFalse: [(self isQuick: (operands at: 0)) ifTrue: [4] ifFalse: [7]]].
		[MoveRM8r]		-> [^(operands at: 2) = ESP
								ifTrue: [7]
								ifFalse: [(self isQuick: (operands at: 1)) ifTrue: [3] ifFalse: [6]]].
		[MoveM16rR]	-> [^(operands at: 1) = ESP
								ifTrue: [(self isQuick: (operands at: 0)) ifTrue: [5] ifFalse: [8]]
								ifFalse: [(self isQuick: (operands at: 0)) ifTrue: [4] ifFalse: [7]]].
		[MoveRM16r]	-> [^(operands at: 2) = ESP
								ifTrue: [8]
								ifFalse: [(self isQuick: (operands at: 1)) ifTrue: [4] ifFalse: [7]]].
		[MoveM64rRd]	-> [^((self isQuick: (operands at: 0))
											ifTrue: [5]
											ifFalse: [8])
										+ ((operands at: 1) = ESP
											ifTrue: [1]
											ifFalse: [0])].
		[MoveM32rRs]	-> [^((self isQuick: (operands at: 0))
											ifTrue: [5]
											ifFalse: [8])
										+ ((operands at: 1) = ESP
											ifTrue: [1]
											ifFalse: [0])].
		[MoveM32rR]		-> [^((self isQuick: (operands at: 0))
									ifTrue: [((operands at: 0) = 0
											and: [(operands at: 1) ~= EBP])
												ifTrue: [2]
												ifFalse: [3]]
									ifFalse: [6])
								+ ((operands at: 1) = ESP
									ifTrue: [1]
									ifFalse: [0])].
		[MoveMwrR]		-> [^((self isQuick: (operands at: 0))
									ifTrue: [((operands at: 0) = 0
											and: [(operands at: 1) ~= EBP])
												ifTrue: [2]
												ifFalse: [3]]
									ifFalse: [6])
								+ ((operands at: 1) = ESP
									ifTrue: [1]
									ifFalse: [0])].
		[MoveXbrRR]	-> [self assert: (operands at: 0) ~= ESP.
							^(operands at: 1) = EBP
											ifTrue: [5]
											ifFalse: [4]].
		[MoveRXbrR]	->	[self assert: (operands at: 1) ~= ESP.
							^((operands at: 2) = EBP
											ifTrue: [4]
											ifFalse: [3])
										+ ((operands at: 0) >= 4
											ifTrue: [2]
											ifFalse: [0])].
		[MoveXwrRR]	-> [self assert: (operands at: 0) ~= ESP.
							^(operands at: 1) = EBP
											ifTrue: [4]
											ifFalse: [3]].
		[MoveRXwrR]	-> [self assert: (operands at: 1) ~= ESP.
							^(operands at: 2) = EBP
											ifTrue: [4]
											ifFalse: [3]].
		[PopR]			-> [^1].
		[PushR]			-> [^1].
		[PushCq]		-> [^(self isQuick: (operands at: 0)) ifTrue: [2] ifFalse: [5]].
		[PushCw]		-> [^5].
		[PrefetchAw]	-> [^self hasSSEInstructions ifTrue: [7] ifFalse: [0]].
		"Conversion"
		[ConvertRRd]	-> [^4].
		[ConvertRdR]	-> [^4].

		[ConvertRsRd]	-> [^4].
		[ConvertRdRs]	-> [^4].
		[ConvertRsR]	-> [^4].
		[ConvertRRs]	-> [^4].

		[SignExtend8RR] -> [^3].
		[SignExtend16RR] -> [^3].
		[ZeroExtend8RR] -> [^3].
		[ZeroExtend16RR] -> [^3]. }.
	^0 "to keep C compiler quiet"