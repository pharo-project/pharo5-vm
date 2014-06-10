generate machine code
computeMaximumSize
	"Compute the maximum size for each opcode.  This allows jump offsets to
	 be determined, provided that all backward branches are long branches."
	"N.B.  The ^maxSize := N forms are to get around the compiler's long branch
	 limits which are exceeded when each case jumps around the otherwise."
	opcode caseOf: {
		"Noops & Pseudo Ops"
		[Label]					-> [^maxSize := 0].
		[AlignmentNops]		-> [^maxSize := (operands at: 0) - 1].
		[Fill16]					-> [^maxSize := 2].
		[Fill32]					-> [^maxSize := 4].
		[FillFromWord]			-> [^maxSize := 4].
		[Nop]					-> [^maxSize := 1].
		"Specific Control/Data Movement"
		[CDQ]					-> [^maxSize := 1].
		[IDIVR]					-> [^maxSize := 2].
		[IMULRR]				-> [^maxSize := 3].
		[CPUID]					-> [^maxSize := 2].
		[CMPXCHGAwR]			-> [^maxSize := 7].
		[CMPXCHGMwrR]		-> [^maxSize := 8].
		[LFENCE]				-> [^maxSize := 3].
		[MFENCE]				-> [^maxSize := 3].
		[SFENCE]				-> [^maxSize := 3].
		[LOCK]					-> [^maxSize := 1].
		[XCHGAwR]				-> [^maxSize := 6].
		[XCHGMwrR]			-> [^maxSize := 7].
		[XCHGRR]				-> [^maxSize := 2].
		"Control"
		[Call]					-> [^maxSize := 5].
		[JumpR]					-> [^maxSize := 2].
		[Jump]					-> [self resolveJumpTarget. ^maxSize := 5].
		[JumpLong]				-> [self resolveJumpTarget. ^maxSize := 5].
		[JumpZero]				-> [self resolveJumpTarget. ^maxSize := 6].
		[JumpNonZero]			-> [self resolveJumpTarget. ^maxSize := 6].
		[JumpNegative]			-> [self resolveJumpTarget. ^maxSize := 6].
		[JumpNonNegative]		-> [self resolveJumpTarget. ^maxSize := 6].
		[JumpOverflow]			-> [self resolveJumpTarget. ^maxSize := 6].
		[JumpNoOverflow]		-> [self resolveJumpTarget. ^maxSize := 6].
		[JumpCarry]				-> [self resolveJumpTarget. ^maxSize := 6].
		[JumpNoCarry]			-> [self resolveJumpTarget. ^maxSize := 6].
		[JumpLess]				-> [self resolveJumpTarget. ^maxSize := 6].
		[JumpGreaterOrEqual]	-> [self resolveJumpTarget. ^maxSize := 6].
		[JumpGreater]			-> [self resolveJumpTarget. ^maxSize := 6].
		[JumpLessOrEqual]		-> [self resolveJumpTarget. ^maxSize := 6].
		[JumpBelow]				-> [self resolveJumpTarget. ^maxSize := 6].
		[JumpAboveOrEqual]		-> [self resolveJumpTarget. ^maxSize := 6].
		[JumpAbove]			-> [self resolveJumpTarget. ^maxSize := 6].
		[JumpBelowOrEqual]		-> [self resolveJumpTarget. ^maxSize := 6].
		[JumpLongZero]			-> [self resolveJumpTarget. ^maxSize := 6].
		[JumpLongNonZero]		-> [self resolveJumpTarget. ^maxSize := 6].
		[JumpFPEqual]			-> [self resolveJumpTarget. ^maxSize := 6].
		[JumpFPNotEqual]		-> [self resolveJumpTarget. ^maxSize := 6].
		[JumpFPLess]			-> [self resolveJumpTarget. ^maxSize := 6].
		[JumpFPGreaterOrEqual]	-> [self resolveJumpTarget. ^maxSize := 6].
		[JumpFPGreater]			-> [self resolveJumpTarget. ^maxSize := 6].
		[JumpFPLessOrEqual]	-> [self resolveJumpTarget. ^maxSize := 6].
		[JumpFPOrdered]		-> [self resolveJumpTarget. ^maxSize := 6].
		[JumpFPUnordered]		-> [self resolveJumpTarget. ^maxSize := 6].
		[RetN]					-> [^maxSize := (operands at: 0) = 0
													ifTrue: [1]
													ifFalse: [3]].
		"Arithmetic"
		[AddCqR]		-> [^maxSize := (self isQuick: (operands at: 0))
											ifTrue: [3]
											ifFalse: [(self concreteRegister: (operands at: 1)) = EAX
														ifTrue: [5]
														ifFalse: [6]]].
		[AndCqR]		-> [^maxSize := (self isQuick: (operands at: 0))
											ifTrue: [3]
											ifFalse: [(self concreteRegister: (operands at: 1)) = EAX
														ifTrue: [5]
														ifFalse: [6]]].
		[CmpCqR]		-> [^maxSize := (self isQuick: (operands at: 0))
											ifTrue: [3]
											ifFalse: [(self concreteRegister: (operands at: 1)) = EAX
														ifTrue: [5]
														ifFalse: [6]]].
		[OrCqR]			-> [^maxSize := (self isQuick: (operands at: 0))
											ifTrue: [3]
											ifFalse: [(self concreteRegister: (operands at: 1)) = EAX
														ifTrue: [5]
														ifFalse: [6]]].
		[SubCqR]		-> [^maxSize := (self isQuick: (operands at: 0))
											ifTrue: [3]
											ifFalse: [(self concreteRegister: (operands at: 1)) = EAX
														ifTrue: [5]
														ifFalse: [6]]].
		[AddCwR]		-> [^maxSize := (self concreteRegister: (operands at: 1)) = EAX
														ifTrue: [5]
														ifFalse: [6]].
		[AndCwR]		-> [^maxSize := (self concreteRegister: (operands at: 1)) = EAX
														ifTrue: [5]
														ifFalse: [6]].
		[CmpCwR]		-> [^maxSize := (self concreteRegister: (operands at: 1)) = EAX
														ifTrue: [5]
														ifFalse: [6]].
		[OrCwR]		-> [^maxSize := (self concreteRegister: (operands at: 1)) = EAX
														ifTrue: [5]
														ifFalse: [6]].
		[SubCwR]		-> [^maxSize := (self concreteRegister: (operands at: 1)) = EAX
														ifTrue: [5]
														ifFalse: [6]].
		[XorCwR]		-> [^maxSize := (self concreteRegister: (operands at: 1)) = EAX
														ifTrue: [5]
														ifFalse: [6]].
		[AddRR]			-> [^maxSize := 2].
		[AndRR]			-> [^maxSize := 2].
		[CmpRR]		-> [^maxSize := 2].
		[OrRR]			-> [^maxSize := 2].
		[XorRR]			-> [^maxSize := 2].
		[SubRR]			-> [^maxSize := 2].
		[NegateR]		-> [^maxSize := 2].
		[LoadEffectiveAddressMwrR]
						-> [^maxSize := ((self isQuick: (operands at: 0))
											ifTrue: [3]
											ifFalse: [6])
										+ ((self concreteRegister: (operands at: 1)) = ESP
											ifTrue: [1]
											ifFalse: [0])].
		[LogicalShiftLeftCqR]		-> [^maxSize := (operands at: 0) = 1
														ifTrue: [2]
														ifFalse: [3]].
		[LogicalShiftRightCqR]	-> [^maxSize := (operands at: 0) = 1
														ifTrue: [2]
														ifFalse: [3]].
		[ArithmeticShiftRightCqR]	-> [^maxSize := (operands at: 0) = 1
														ifTrue: [2]
														ifFalse: [3]].
		[LogicalShiftLeftRR]		-> [self computeShiftRRSize].
		[LogicalShiftRightRR]		-> [self computeShiftRRSize].
		[ArithmeticShiftRightRR]	-> [self computeShiftRRSize].
		[AddRdRd]				-> [^maxSize := 4].
		[CmpRdRd]				-> [^maxSize := 4].
		[SubRdRd]				-> [^maxSize := 4].
		[MulRdRd]				-> [^maxSize := 4].
		[DivRdRd]				-> [^maxSize := 4].
		[SqrtRd]					-> [^maxSize := 4].
		"Data Movement"
		[MoveCqR]		-> [^maxSize := (operands at: 0) = 0 ifTrue: [2] ifFalse: [5]].
		[MoveCwR]		-> [^maxSize := 5].
		[MoveRR]		-> [^maxSize := 2].
		[MoveRdRd]		-> [^maxSize := 4].
		[MoveAwR]		-> [^maxSize := (self concreteRegister: (operands at: 1)) = EAX
											ifTrue: [5]
											ifFalse: [6]].
		[MoveRAw]		-> [^maxSize := (self concreteRegister: (operands at: 0)) = EAX
											ifTrue: [5]
											ifFalse: [6]].
		[MoveRMwr]		-> [^maxSize := ((self isQuick: (operands at: 1))
											ifTrue: [3]
											ifFalse: [6])
										+ ((self concreteRegister: (operands at: 2)) = ESP
											ifTrue: [1]
											ifFalse: [0])].
		[MoveRdM64r]	-> [^maxSize := ((self isQuick: (operands at: 1))
											ifTrue: [5]
											ifFalse: [8])
										+ ((self concreteRegister: (operands at: 2)) = ESP
											ifTrue: [1]
											ifFalse: [0])].
		[MoveMbrR]		-> [^maxSize := ((self isQuick: (operands at: 0))
											ifTrue: [3]
											ifFalse: [6])
										+ ((self concreteRegister: (operands at: 1)) = ESP
											ifTrue: [1]
											ifFalse: [0])].
		[MoveRMbr]		-> [^maxSize := ((self isQuick: (operands at: 1))
											ifTrue: [3]
											ifFalse: [6])
										+ ((self concreteRegister: (operands at: 2)) = ESP
											ifTrue: [1]
											ifFalse: [0])].
		[MoveM16rR]	-> [^maxSize := ((self isQuick: (operands at: 0))
											ifTrue: [4]
											ifFalse: [7])
										+ ((self concreteRegister: (operands at: 1)) = ESP
											ifTrue: [1]
											ifFalse: [0])].
		[MoveM64rRd]	-> [^maxSize := ((self isQuick: (operands at: 0))
											ifTrue: [5]
											ifFalse: [8])
										+ ((self concreteRegister: (operands at: 1)) = ESP
											ifTrue: [1]
											ifFalse: [0])].
		[MoveMwrR]		-> [^maxSize := ((self isQuick: (operands at: 0))
											ifTrue: [3]
											ifFalse: [6])
										+ ((self concreteRegister: (operands at: 1)) = ESP
											ifTrue: [1]
											ifFalse: [0])].
		[MoveXbrRR]	-> [self assert: (self concreteRegister: (operands at: 0)) ~= ESP.
							^maxSize := (self concreteRegister: (operands at: 1)) = EBP
											ifTrue: [5]
											ifFalse: [4]].
		[MoveRXbrR]	->	[self assert: (self concreteRegister: (operands at: 1)) ~= ESP.
							^maxSize := (self concreteRegister: (operands at: 2)) = EBP
											ifTrue: [4]
											ifFalse: [3]].
		[MoveXwrRR]	-> [self assert: (self concreteRegister: (operands at: 0)) ~= ESP.
							^maxSize := (self concreteRegister: (operands at: 1)) = EBP
											ifTrue: [4]
											ifFalse: [3]].
		[MoveRXwrR]	-> [self assert: (self concreteRegister: (operands at: 1)) ~= ESP.
							^maxSize := (self concreteRegister: (operands at: 2)) = EBP
											ifTrue: [4]
											ifFalse: [3]].
		[PopR]			-> [^maxSize := 1].
		[PushR]			-> [^maxSize := 1].
		[PushCw]		-> [^maxSize := 5].
		[PrefetchAw]	-> [^maxSize := self hasSSEInstructions ifTrue: [7] ifFalse: [0]].
		"Conversion"
		[ConvertRRd]	-> [^maxSize := 4] }.
	^0 "to keep C compiler quiet"