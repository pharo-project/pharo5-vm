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
		[Fill16]					-> [^2].
		[Fill32]					-> [^4].
		[FillFromWord]			-> [^4].
		[Nop]					-> [^1].
		"Specific Control/Data Movement"
		[CDQ]					-> [^1].
		[IDIVR]					-> [^2].
		[IMULRR]				-> [^3].
		[CPUID]					-> [^2].
		[CMPXCHGAwR]			-> [^7].
		[CMPXCHGMwrR]		-> [^(self concreteRegister: (operands at: 1)) = ESP
										ifTrue: [(self isQuick: (operands at: 0)) ifTrue: [5] ifFalse: [8]]
										ifFalse: [(self isQuick: (operands at: 0)) ifTrue: [4] ifFalse: [7]]].
		[LFENCE]				-> [^3].
		[MFENCE]				-> [^3].
		[SFENCE]				-> [^3].
		[LOCK]					-> [^1].
		[XCHGAwR]				-> [^6].
		[XCHGMwrR]			-> [^(self concreteRegister: (operands at: 1)) = ESP
										ifTrue: [(self isQuick: (operands at: 0)) ifTrue: [4] ifFalse: [7]]
										ifFalse: [(self isQuick: (operands at: 0)) ifTrue: [3] ifFalse: [6]]].
		[XCHGRR]				-> [^((self concreteRegister: (operands at: 0)) = EAX
									   or: [(self concreteRegister: (operands at: 1)) = EAX])
										ifTrue: [1]
										ifFalse: [2]].
		"Control"
		[CallFull]					-> [^5].
		[Call]						-> [^5].
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
											ifFalse: [(self concreteRegister: (operands at: 1)) = EAX
														ifTrue: [5]
														ifFalse: [6]]].
		[AndCqR]		-> [^(self isQuick: (operands at: 0))
											ifTrue: [3]
											ifFalse: [(self concreteRegister: (operands at: 1)) = EAX
														ifTrue: [5]
														ifFalse: [6]]].
		[CmpCqR]		-> [^(self isQuick: (operands at: 0))
											ifTrue: [3]
											ifFalse: [(self concreteRegister: (operands at: 1)) = EAX
														ifTrue: [5]
														ifFalse: [6]]].
		[OrCqR]			-> [^(self isQuick: (operands at: 0))
											ifTrue: [3]
											ifFalse: [(self concreteRegister: (operands at: 1)) = EAX
														ifTrue: [5]
														ifFalse: [6]]].
		[SubCqR]		-> [^(self isQuick: (operands at: 0))
											ifTrue: [3]
											ifFalse: [(self concreteRegister: (operands at: 1)) = EAX
														ifTrue: [5]
														ifFalse: [6]]].
		[TstCqR]		-> [^((self isQuick: (operands at: 0)) and: [(self concreteRegister: (operands at: 1)) < 4])
											ifTrue: [3]
											ifFalse: [(self concreteRegister: (operands at: 1)) = EAX
														ifTrue: [5]
														ifFalse: [6]]].
		[AddCwR]		-> [^(self concreteRegister: (operands at: 1)) = EAX ifTrue: [5] ifFalse: [6]].
		[AndCwR]		-> [^(self concreteRegister: (operands at: 1)) = EAX ifTrue: [5] ifFalse: [6]].
		[CmpCwR]		-> [^(self concreteRegister: (operands at: 1)) = EAX ifTrue: [5] ifFalse: [6]].
		[OrCwR]		-> [^(self concreteRegister: (operands at: 1)) = EAX ifTrue: [5] ifFalse: [6]].
		[SubCwR]		-> [^(self concreteRegister: (operands at: 1)) = EAX ifTrue: [5] ifFalse: [6]].
		[XorCwR]		-> [^(self concreteRegister: (operands at: 1)) = EAX ifTrue: [5] ifFalse: [6]].
		[AddRR]			-> [^2].
		[AndRR]			-> [^2].
		[CmpRR]		-> [^2].
		[OrRR]			-> [^2].
		[XorRR]			-> [^2].
		[SubRR]			-> [^2].
		[NegateR]		-> [^2].
		[LoadEffectiveAddressMwrR]
						-> [^((self isQuick: (operands at: 0))
											ifTrue: [3]
											ifFalse: [6])
										+ ((self concreteRegister: (operands at: 1)) = ESP
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
		"Data Movement"
		[MoveCqR]		-> [^(operands at: 0) = 0 ifTrue: [2] ifFalse: [5]].
		[MoveCwR]		-> [^5].
		[MoveRR]		-> [^2].
		[MoveRdRd]		-> [^4].
		[MoveAwR]		-> [^(self concreteRegister: (operands at: 1)) = EAX ifTrue: [5] ifFalse: [6]].
		[MoveRAw]		-> [^(self concreteRegister: (operands at: 0)) = EAX ifTrue: [5] ifFalse: [6]].
		[MoveAbR]		-> [^(self concreteRegister: (operands at: 1)) = EAX ifTrue: [5] ifFalse: [6]].
		[MoveRAb]		-> [^(self concreteRegister: (operands at: 0)) = EAX ifTrue: [5] ifFalse: [6]].
		[MoveRMwr]	-> [^((self isQuick: (operands at: 1))
									ifTrue: [((operands at: 1) = 0
											and: [(self concreteRegister: (operands at: 2)) ~= EBP])
												ifTrue: [2]
												ifFalse: [3]]
									ifFalse: [6])
								+ ((self concreteRegister: (operands at: 2)) = ESP
									ifTrue: [1]
									ifFalse: [0])].
		[MoveRdM64r]	-> [^((self isQuick: (operands at: 1))
											ifTrue: [5]
											ifFalse: [8])
										+ ((self concreteRegister: (operands at: 2)) = ESP
											ifTrue: [1]
											ifFalse: [0])].
		[MoveMbrR]		-> [^(self concreteRegister: (operands at: 1)) = ESP
								ifTrue: [(self isQuick: (operands at: 0)) ifTrue: [5] ifFalse: [8]]
								ifFalse: [(self isQuick: (operands at: 0)) ifTrue: [4] ifFalse: [7]]].
		[MoveRMbr]		-> [^(self concreteRegister: (operands at: 2)) = ESP
								ifTrue: [7]
								ifFalse: [(self isQuick: (operands at: 1)) ifTrue: [3] ifFalse: [6]]].
		[MoveM16rR]	-> [^(self concreteRegister: (operands at: 1)) = ESP
								ifTrue: [(self isQuick: (operands at: 0)) ifTrue: [5] ifFalse: [8]]
								ifFalse: [(self isQuick: (operands at: 0)) ifTrue: [4] ifFalse: [7]]].
		[MoveM64rRd]	-> [^((self isQuick: (operands at: 0))
											ifTrue: [5]
											ifFalse: [8])
										+ ((self concreteRegister: (operands at: 1)) = ESP
											ifTrue: [1]
											ifFalse: [0])].
		[MoveMwrR]		-> [^((self isQuick: (operands at: 0))
									ifTrue: [((operands at: 0) = 0
											and: [(self concreteRegister: (operands at: 1)) ~= EBP])
												ifTrue: [2]
												ifFalse: [3]]
									ifFalse: [6])
								+ ((self concreteRegister: (operands at: 1)) = ESP
									ifTrue: [1]
									ifFalse: [0])].
		[MoveXbrRR]	-> [self assert: (self concreteRegister: (operands at: 0)) ~= ESP.
							^(self concreteRegister: (operands at: 1)) = EBP
											ifTrue: [5]
											ifFalse: [4]].
		[MoveRXbrR]	->	[self assert: (self concreteRegister: (operands at: 1)) ~= ESP.
							^((self concreteRegister: (operands at: 2)) = EBP
											ifTrue: [4]
											ifFalse: [3])
										+ ((self concreteRegister: (operands at: 0)) >= 4
											ifTrue: [2]
											ifFalse: [0])].
		[MoveXwrRR]	-> [self assert: (self concreteRegister: (operands at: 0)) ~= ESP.
							^(self concreteRegister: (operands at: 1)) = EBP
											ifTrue: [4]
											ifFalse: [3]].
		[MoveRXwrR]	-> [self assert: (self concreteRegister: (operands at: 1)) ~= ESP.
							^(self concreteRegister: (operands at: 2)) = EBP
											ifTrue: [4]
											ifFalse: [3]].
		[PopR]			-> [^1].
		[PushR]			-> [^1].
		[PushCq]		-> [^(self isQuick: (operands at: 0)) ifTrue: [2] ifFalse: [5]].
		[PushCw]		-> [^5].
		[PrefetchAw]	-> [^self hasSSEInstructions ifTrue: [7] ifFalse: [0]].
		"Conversion"
		[ConvertRRd]	-> [^4] }.
	^0 "to keep C compiler quiet"