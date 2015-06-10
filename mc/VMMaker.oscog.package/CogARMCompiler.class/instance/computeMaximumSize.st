generate machine code
computeMaximumSize
	"Because we don't use Thumb, each ARM instruction has 4 bytes. Many abstract opcodes need more than one instruction.
	 Instructions that refer to constants and/or literals depend on literals being stored in-line or out-of-line."

	opcode
		caseOf: {
		"Noops & Pseudo Ops"
		[Label]					-> [^maxSize := 0].
		[Literal]					-> [^maxSize := 4].
		[AlignmentNops]		-> [^maxSize := (operands at: 0) - 4].
		[Fill16]					-> [^maxSize := 4].
		[Fill32]					-> [^maxSize := 4].
		[FillFromWord]			-> [^maxSize := 4].
		[Nop]					-> [^maxSize := 4].
		"Control"
		[Call]					-> [^maxSize := 4].
		[CallFull]				-> [^maxSize := self literalLoadInstructionBytes + 4].
		[JumpR]					-> [^maxSize := 4].
		[Jump]					-> [^maxSize := 4].
		[JumpFull]				-> [^maxSize := self literalLoadInstructionBytes + 4].
		[JumpLong]				-> [^maxSize := 4].
		[JumpZero]				-> [^maxSize := 4].
		[JumpNonZero]			-> [^maxSize := 4].
		[JumpNegative]			-> [^maxSize := 4].
		[JumpNonNegative]		-> [^maxSize := 4].
		[JumpOverflow]			-> [^maxSize := 4].
		[JumpNoOverflow]		-> [^maxSize := 4].
		[JumpCarry]			-> [^maxSize := 4].
		[JumpNoCarry]			-> [^maxSize := 4].
		[JumpLess]				-> [^maxSize := 4].
		[JumpGreaterOrEqual]	-> [^maxSize := 4].
		[JumpGreater]			-> [^maxSize := 4].
		[JumpLessOrEqual]		-> [^maxSize := 4].
		[JumpBelow]			-> [^maxSize := 4].
		[JumpAboveOrEqual]	-> [^maxSize := 4].
		[JumpAbove]			-> [^maxSize := 4].
		[JumpBelowOrEqual]	-> [^maxSize := 4].
		[JumpLongZero]		-> [^maxSize := 4].
		[JumpLongNonZero]	-> [^maxSize := 4].
		[JumpFPEqual]			-> [^maxSize := 8].
		[JumpFPNotEqual]		-> [^maxSize := 8].
		[JumpFPLess]			-> [^maxSize := 8].
		[JumpFPGreaterOrEqual]-> [^maxSize := 8].
		[JumpFPGreater]		-> [^maxSize := 8].
		[JumpFPLessOrEqual]	-> [^maxSize := 8].
		[JumpFPOrdered]		-> [^maxSize := 8].
		[JumpFPUnordered]		-> [^maxSize := 8].
		[RetN]					-> [^maxSize := (operands at: 0) = 0 ifTrue: [4] ifFalse: [8]].
		[Stop]					-> [^maxSize := 4].

		"Arithmetic"
		[AddCqR]				-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse:
												[self rotateable8bitImmediate: (operands at: 0) negated
													ifTrue: [:r :i| maxSize := 4]
													ifFalse: [maxSize := self literalLoadInstructionBytes + 4]]].
		[AndCqR]				-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := self literalLoadInstructionBytes + 4]].
		[AndCqRR]				-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse:
												[| val invVal |
												invVal := (val := operands at: 0) < 0 ifTrue: [-1 - val] ifFalse: [val bitInvert32].
												self rotateable8bitImmediate: invVal
													ifTrue: [:r :i| maxSize := 4]
													ifFalse: [maxSize := self literalLoadInstructionBytes + 4]]].
		[CmpCqR]				-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := self literalLoadInstructionBytes + 4]].
		[OrCqR]					-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := self literalLoadInstructionBytes + 4]].
		[SubCqR]				-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse:
												[self rotateable8bitImmediate: (operands at: 0) negated
													ifTrue: [:r :i| maxSize := 4]
													ifFalse: [maxSize := self literalLoadInstructionBytes + 4]]].
		[TstCqR]				-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := self literalLoadInstructionBytes + 4]].
		[XorCqR]				-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := self literalLoadInstructionBytes + 4]].
		[AddCwR]				-> [^maxSize := self literalLoadInstructionBytes + 4].
		[AndCwR]				-> [^maxSize := self literalLoadInstructionBytes + 4].
		[CmpCwR]				-> [^maxSize := self literalLoadInstructionBytes + 4].
		[OrCwR]				-> [^maxSize := self literalLoadInstructionBytes + 4].
		[SubCwR]				-> [^maxSize := self literalLoadInstructionBytes + 4].
		[XorCwR]				-> [^maxSize := self literalLoadInstructionBytes + 4].
		[AddRR]					-> [^maxSize := 4].
		[AndRR]					-> [^maxSize := 4].
		[CmpRR]				-> [^maxSize := 4].
		[OrRR]					-> [^maxSize := 4].
		[XorRR]					-> [^maxSize := 4].
		[SubRR]					-> [^maxSize := 4].
		[NegateR]				-> [^maxSize := 4].
		[LoadEffectiveAddressMwrR]
									-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := self literalLoadInstructionBytes + 4]].

		[LogicalShiftLeftCqR]		-> [^maxSize := 4].
		[LogicalShiftRightCqR]		-> [^maxSize := 4].
		[ArithmeticShiftRightCqR]	-> [^maxSize := 4].
		[LogicalShiftLeftRR]			-> [^maxSize := 4].
		[LogicalShiftRightRR]		-> [^maxSize := 4].
		[ArithmeticShiftRightRR]		-> [^maxSize := 4].
		[AddRdRd]					-> [^maxSize := 4].
		[CmpRdRd]					-> [^maxSize := 4].
		[SubRdRd]					-> [^maxSize := 4].
		[MulRdRd]					-> [^maxSize := 4].
		[DivRdRd]					-> [^maxSize := 4].
		[SqrtRd]					-> [^maxSize := 4].
		"ARM Specific Arithmetic"
		[SMULL]				-> [^maxSize := 4].
		[MSR]					-> [^maxSize := 4].
		[CMPSMULL]			-> [^maxSize := 4]. "special compare for genMulR:R: usage"
		"Data Movement"						
		[MoveCqR]				-> [^self literalLoadInstructionBytes = 4
										ifTrue: [maxSize := self literalLoadInstructionBytes]
										ifFalse:
											[self rotateable8bitImmediate: (operands at: 0)
												ifTrue: [:r :i| maxSize := 4]
												ifFalse:
													[| val invVal |
													invVal := (val := operands at: 0) < 0 ifTrue: [-1 - val] ifFalse: [val bitInvert32].
													self rotateable8bitImmediate: invVal
														ifTrue: [:r :i| maxSize := 4]
														ifFalse: [maxSize := self literalLoadInstructionBytes]]]].
		[MoveCwR]				-> [^maxSize := self literalLoadInstructionBytes].
		[MoveRR]				-> [^maxSize := 4].
		[MoveRdRd]				-> [^maxSize := 4].
		[MoveAwR]				-> [^maxSize := (self isAddressRelativeToVarBase: (operands at: 0))
													ifTrue: [4]
													ifFalse: [self literalLoadInstructionBytes + 4]].
		[MoveRAw]				-> [^maxSize := (self isAddressRelativeToVarBase: (operands at: 1))
													ifTrue: [4]
													ifFalse: [self literalLoadInstructionBytes + 4]].
		[MoveRMwr]			-> [^self is12BitValue: (operands at: 1)
										ifTrue: [:u :i| maxSize := 4]
										ifFalse: [maxSize := self literalLoadInstructionBytes + 4]].
		[MoveRdM64r]			-> [^maxSize := self literalLoadInstructionBytes + 4]. 
		[MoveMbrR]				-> [^self is12BitValue: (operands at: 0)
										ifTrue: [:u :i| maxSize := 4]
										ifFalse: [maxSize := self literalLoadInstructionBytes + 4]].
		[MoveRMbr]				-> [^self is12BitValue: (operands at: 1)
										ifTrue: [:u :i| maxSize := 4]
										ifFalse: [maxSize := self literalLoadInstructionBytes + 4]].
		[MoveM16rR]			-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := self literalLoadInstructionBytes + 4]].
		[MoveM64rRd]			-> [^maxSize := self literalLoadInstructionBytes + 4].
		[MoveMwrR]			-> [^self is12BitValue: (operands at: 0)
										ifTrue: [:u :i| maxSize := 4]
										ifFalse: [maxSize := self literalLoadInstructionBytes + 4]].
		[MoveXbrRR]			-> [^maxSize := 4].
		[MoveRXbrR]			-> [^maxSize := 4].
		[MoveXwrRR]			-> [^maxSize := 4].
		[MoveRXwrR]			-> [^maxSize := 4].
		[PopR]					-> [^maxSize := 4].
		[PushR]					-> [^maxSize := 4].
		[PushCw]				-> [^maxSize := self literalLoadInstructionBytes + 4].
		[PushCq]				-> [^self literalLoadInstructionBytes = 4
										ifTrue: [maxSize := self literalLoadInstructionBytes + 4]
										ifFalse:
											[self rotateable8bitImmediate: (operands at: 0)
												ifTrue: [:r :i| maxSize := 8]
												ifFalse:
													[| val invVal |
													invVal := (val := operands at: 0) < 0 ifTrue: [-1 - val] ifFalse: [val bitInvert32].
													self rotateable8bitImmediate: invVal
														ifTrue: [:r :i| maxSize := 8]
														ifFalse: [maxSize := self literalLoadInstructionBytes + 4]]]].
		[PrefetchAw] 			-> [^maxSize := (self isAddressRelativeToVarBase: (operands at: 1))
													ifTrue: [4]
													ifFalse: [self literalLoadInstructionBytes + 4]].
		"Conversion"
		[ConvertRRd]			-> [^maxSize := 4].
		}.
	^0 "to keep C compiler quiet"
