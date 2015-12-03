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
		[CDQ]					-> [^2].
		[IDIVR]					-> [^3].
		[IMULRR]				-> [^4].
		[CPUID]					-> [^2].
		[CMPXCHGAwR]			-> [^8].
		[CMPXCHGMwrR]		-> [^9].
		[LFENCE]				-> [^3].
		[MFENCE]				-> [^3].
		[SFENCE]				-> [^3].
		[LOCK]					-> [^1].
		"[XCHGAwR]				-> [^6].
		[XCHGMwrR]			-> [^7]."
		[XCHGRR]				-> [^((self concreteRegister: (operands at: 0)) = RAX
									   or: [(self concreteRegister: (operands at: 1)) = RAX])
											ifTrue: [2]
											ifFalse: [3]].
		"Control"
		[CallFull]					-> [^12].
		[Call]						-> [^5].
		[JumpR]						-> [^2].
		[JumpFull]					-> [self resolveJumpTarget. ^12].
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
		[AddCqR]		-> [^self computeSizeOfArithCqR].
		[AndCqR]		-> [^self computeSizeOfArithCqR].
		[CmpCqR]		-> [^self computeSizeOfArithCqR].
		[OrCqR]			-> [^self computeSizeOfArithCqR].
		[SubCqR]		-> [^self computeSizeOfArithCqR].
		[TstCqR]		-> [^self computeSizeOfArithCqR].
		[AddCwR]		-> [^self computeSizeOfArithCwR].
		[AndCwR]		-> [^self computeSizeOfArithCwR].
		[CmpCwR]		-> [^self computeSizeOfArithCwR].
		[CmpC32R]		-> [^self computeSizeOfArithCwR].
		[OrCwR]		-> [^self computeSizeOfArithCwR].
		[SubCwR]		-> [^self computeSizeOfArithCwR].
		[XorCwR]		-> [^self computeSizeOfArithCwR].
		[AddRR]			-> [^3].
		[AndRR]			-> [^3].
		[CmpRR]		-> [^3].
		[OrRR]			-> [^3].
		[XorRR]			-> [^3].
		[SubRR]			-> [^3].
		[NegateR]		-> [^3].
		[LoadEffectiveAddressMwrR]
						-> [^((self isQuick: (operands at: 0))
									ifTrue: [4]
									ifFalse: [7])
								+ (((self concreteRegister: (operands at: 1)) bitAnd: 7) = RSP
									ifTrue: [1]
									ifFalse: [0])].
		[LogicalShiftLeftCqR]		-> [^(operands at: 0) = 1 ifTrue: [3] ifFalse: [4]].
		[LogicalShiftRightCqR]		-> [^(operands at: 0) = 1 ifTrue: [3] ifFalse: [4]].
		[ArithmeticShiftRightCqR]	-> [^(operands at: 0) = 1 ifTrue: [3] ifFalse: [4]].
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
		[MoveCqR]		-> [^(operands at: 0) = 0
								ifTrue: [3]
								ifFalse:
									[(self is32BitSignedImmediate: (operands at: 0))
										ifTrue: [7]
										ifFalse: [self moveCwRByteSize]]].
		[MoveCwR]		-> [^(self inCurrentCompilation: (operands at: 0))
								ifTrue: [7]
								ifFalse: [self moveCwRByteSize]].
		[MoveC32R]	-> [^7]. "N.B. Always inlined."
		[MoveRR]		-> [^3].
		[MoveRdRd]		-> [^4].
		[MoveRRd]		-> [^5].
		[MoveRdR]		-> [^5].
		[MoveAwR]		-> [^(self isAddressRelativeToVarBase: (operands at: 0))
								ifTrue: [7]
								ifFalse: [(self concreteRegister: (operands at: 1)) = RAX ifTrue: [10] ifFalse: [14]]].
		[MoveRAw]		-> [^(self isAddressRelativeToVarBase: (operands at: 1))
								ifTrue: [7]
								ifFalse: [(self concreteRegister: (operands at: 0)) = RAX ifTrue: [10] ifFalse: [14]]].
		[MoveAbR]		-> [^(self isAddressRelativeToVarBase: (operands at: 0))
								ifTrue: [7]
								ifFalse: [(self concreteRegister: (operands at: 1)) = RAX ifTrue: [10] ifFalse: [14]]].
		[MoveRAb]		-> [^(self isAddressRelativeToVarBase: (operands at: 1))
								ifTrue: [7]
								ifFalse: [(self concreteRegister: (operands at: 0)) = RAX ifTrue: [10] ifFalse: [14]]].
		[MoveRMwr]	-> [self assert: (self is32BitSignedImmediate: (operands at: 1)).
							^((self isQuick: (operands at: 1))
									ifTrue: [((operands at: 1) = 0
											and: [((self concreteRegister: (operands at: 2)) bitAnd: 7) ~= RBP])
												ifTrue: [3]
												ifFalse: [4]]
									ifFalse: [7])
								+ (((self concreteRegister: (operands at: 2)) bitAnd: 7) = RSP
									ifTrue: [1]
									ifFalse: [0])].
		[MoveRdM64r]	-> [^((self isQuick: (operands at: 1))
											ifTrue: [5]
											ifFalse: [8])
										+ ((((self concreteRegister: (operands at: 2)) bitAnd: 7) between: RSP and: RBP)
											ifTrue: [1]
											ifFalse: [0])].
		[MoveMbrR]		-> [self assert: (self is32BitSignedImmediate: (operands at: 0)).
							^((self isQuick: (operands at: 0))
									ifTrue: [((operands at: 0) = 0
											and: [((self concreteRegister: (operands at: 1)) bitAnd: 7) ~= RBP])
												ifTrue: [3]
												ifFalse: [4]]
									ifFalse: [7])
								+ (((self concreteRegister: (operands at: 1)) bitAnd: 7) = RSP
									ifTrue: [1]
									ifFalse: [0])].
		[MoveRMbr]		-> [self assert: (self is32BitSignedImmediate: (operands at: 1)).
							^((self isQuick: (operands at: 1))
									ifTrue: [((operands at: 1) = 0
											and: [((self concreteRegister: (operands at: 0)) bitAnd: 7) ~= RBP])
												ifTrue: [3]
												ifFalse: [4]]
									ifFalse: [7])
								+ (((self concreteRegister: (operands at: 2)) bitAnd: 7) = RSP
									ifTrue: [1]
									ifFalse: [0])].
		[MoveM16rR]	-> [^((self isQuick: (operands at: 0))
									ifTrue: [((operands at: 0) = 0
											and: [((self concreteRegister: (operands at: 1)) bitAnd: 7) ~= RBP])
												ifTrue: [4]
												ifFalse: [5]]
									ifFalse: [8])
								+ (((self concreteRegister: (operands at: 1)) bitAnd: 7) = RSP
									ifTrue: [1]
									ifFalse: [0])].
		[MoveM64rRd]	-> [^((self isQuick: (operands at: 0))
								ifTrue: [((operands at: 0) = 0
										and: [((self concreteRegister: (operands at: 1)) bitAnd: 6) ~= RSP])
											ifTrue: [4]
											ifFalse: [5]]
								ifFalse: [8])
							+ ((((self concreteRegister: (operands at: 1)) bitAnd: 7) = RSP and: [(operands at: 0) ~= 0])
								ifTrue: [1]
								ifFalse: [0])
							+ ((((self concreteRegister: (operands at: 1)) > 7) or: [(self concreteDPFPRegister: (operands at: 2)) > 7])
								ifTrue: [1]
								ifFalse: [0])].
		[MoveMwrR]	-> [self assert: (self is32BitSignedImmediate: (operands at: 0)).
							^((self isQuick: (operands at: 0))
								ifTrue: [((operands at: 0) = 0
										and: [((self concreteRegister: (operands at: 1)) bitAnd: 7) ~= RBP])
											ifTrue: [3]
											ifFalse: [4]]
								ifFalse: [7])
							+ (((self concreteRegister: (operands at: 1)) bitAnd: 7) = RSP
								ifTrue: [1]
								ifFalse: [0])].
		[MoveXbrRR]	-> [self assert: (self concreteRegister: (operands at: 0)) ~= RSP.
							^((self concreteRegister: (operands at: 1)) bitAnd: 7) = RBP
											ifTrue: [5]
											ifFalse: [4]].
		[MoveRXbrR]	->	[self assert: (self concreteRegister: (operands at: 1)) ~= RSP.
							^(((self concreteRegister: (operands at: 0)) < 8
							   and: [(self concreteRegister: (operands at: 1)) < 8
							   and: [(self concreteRegister: (operands at: 2)) < 8]])
								ifTrue: [3]
								ifFalse: [4])
							+ (((self concreteRegister: (operands at: 2)) bitAnd: 7) = RBP
											ifTrue: [1]
											ifFalse: [0])].
		[MoveXwrRR]	-> [self assert: (self concreteRegister: (operands at: 0)) ~= RSP.
							^((self concreteRegister: (operands at: 1)) = RBP
							   or: [(self concreteRegister: (operands at: 1)) = R13])
											ifTrue: [5]
											ifFalse: [4]].
		[MoveRXwrR]	-> [self assert: (self concreteRegister: (operands at: 1)) ~= RSP.
							^((self concreteRegister: (operands at: 2)) = RBP
							   or: [(self concreteRegister: (operands at: 2)) = R13])
											ifTrue: [5]
											ifFalse: [4]].
		[MoveX32rRR]	-> [self assert: (self concreteRegister: (operands at: 0)) ~= RSP.
							^(((self concreteRegister: (operands at: 1)) = RBP
							   or: [(self concreteRegister: (operands at: 1)) = R13])
										ifTrue: [7]
										ifFalse: [6])
							 + (((self concreteRegister: (operands at: 0)) > 7
							     or: [(self concreteRegister: (operands at: 1)) > 7
							     or: [(self concreteRegister: (operands at: 2)) > 7]])
										ifTrue: [1]
										ifFalse: [0])].
		[PopR]			-> [^(self concreteRegister: (operands at: 0)) < 8 ifTrue: [1] ifFalse: [2]].
		[PushR]			-> [^(self concreteRegister: (operands at: 0)) < 8 ifTrue: [1] ifFalse: [2]].
		[PushCq]		-> [^(self isQuick: (operands at: 0)) ifTrue: [2] ifFalse: [5]].
		[PushCw]		-> [^(self inCurrentCompilation: (operands at: 0))
								ifTrue: [9]
								ifFalse: [self pushCwByteSize]].
		[PrefetchAw]	-> [^(self isAddressRelativeToVarBase: (operands at: 0)) ifTrue: [7] ifFalse: [0]].
		"Conversion"
		[ConvertRRd]	-> [^5] }.
	^0 "to keep C compiler quiet"