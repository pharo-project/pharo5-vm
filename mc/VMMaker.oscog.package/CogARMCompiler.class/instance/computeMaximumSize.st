generate machine code
computeMaximumSize
	"Because we don't use Thumb, each ARM instruction has 4 bytes. Some abstract opcodes need more than one instruction. We only handle those in this caseOf: and let the default return 4"
	
	
	opcode
		caseOf: {
		"Noops & Pseudo Ops"
		[Label]					-> [^maxSize := 0].
		[AlignmentNops]		-> [^maxSize := (operands at: 0) - 4].
		[Fill16]					-> [^maxSize := 4].
		[Fill32]					-> [^maxSize := 4].
		[FillFromWord]			-> [^maxSize := 4].
		[Nop]					-> [^maxSize := 4].
		"ARM Specific Control/Data Movement"
		[BICCqR]				-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := 20]].
		[TstCqR]				-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := 20]].
		[SMULL]				-> [^maxSize := 4].
		"Control"
		[Call]					-> [^maxSize := 4].
		[CallFull]				-> [^maxSize := 20].
		[JumpR]					-> [^maxSize := 4].
		[Jump]					-> [^maxSize := 4].
		[JumpFull]				-> [^maxSize := 20].
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
		[RetN]					-> [^(operands at: 0) = 0 
										ifTrue: [maxSize := 4]
										ifFalse: [maxSize := 8]].
		[Stop]					-> [^maxSize := 4].

		"Arithmetic"
		[AddCqR]				-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := 20]].
		[AndCqR]				-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := 20]].
		[AndCqRR]				-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := 20]].
		[CmpCqR]				-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := 20]].
		[OrCqR]					-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := 20]].
		[SubCqR]				-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := 20]].
		[XorCqR]				-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := 20]].
		[AddCwR]				-> [^maxSize := 20].
		[AndCwR]				-> [^maxSize := 20].
		[CmpCwR]				-> [^maxSize := 20].
		[OrCwR]				-> [^maxSize := 20].
		[SubCwR]				-> [^maxSize := 20].
		[XorCwR]				-> [^maxSize := 20].
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
											ifFalse: [maxSize := 20]].

		[LogicalShiftLeftCqR]		-> [^maxSize := 4].
		[LogicalShiftRightCqR]		->  [^maxSize := 4].
		[ArithmeticShiftRightCqR]	-> [^maxSize := 4].
		[LogicalShiftLeftRR]			->  [^maxSize := 4].
		[LogicalShiftRightRR]		->  [^maxSize := 4].
		[ArithmeticShiftRightRR]		-> [^maxSize := 4].
		[AddRdRd]			-> [^maxSize := 4].
		[CmpRdRd]			-> [^maxSize := 4].
		[SubRdRd]			-> [^maxSize := 4].
		[MulRdRd]			-> [^maxSize := 4].
		[DivRdRd]			-> [^maxSize := 4].
		[SqrtRd]			-> [^maxSize := 4].		
		"Data Movement"						
		[MoveCqR]				-> [^self rotateable8bitImmediate: (operands at: 0)
										ifTrue: [:r :i| maxSize := 4]
										ifFalse: [maxSize := 16]].
		[MoveCwR]				-> [^maxSize := 16].
		[MoveRR]				-> [^maxSize := 4].
		[MoveRdRd]		-> [^maxSize := 4].
		[MoveAwR]				-> [^maxSize := (self isAddressRelativeToVarBase: (operands at: 0))
													ifTrue: [4]
													ifFalse: [20]].
		[MoveRAw]				-> [^maxSize := (self isAddressRelativeToVarBase: (operands at: 1))
													ifTrue: [4]
													ifFalse: [20]].
		[MoveRMwr]			-> [self is12BitValue: (operands at: 1)
										ifTrue: [ :u :i | ^maxSize := 4]
										ifFalse: [ ^maxSize := 20 ]].
		[MoveRdM64r]	-> [^maxSize := 20]. 
		[MoveMbrR]				-> [self is12BitValue: (operands at: 0)
										ifTrue: [ :u :i | ^maxSize := 4]
										ifFalse: [ ^maxSize := 20 ]].
		[MoveRMbr]				-> [self is12BitValue: (operands at: 1)
										ifTrue: [ :u :i | ^maxSize := 4]
										ifFalse: [ ^maxSize := 20 ]].
		[MoveM16rR]			-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := 20]].
		[MoveM64rRd]	-> [^maxSize := 20].
		[MoveMwrR]			-> [self is12BitValue: (operands at: 0)
										ifTrue: [ :u :i | ^maxSize := 4]
										ifFalse: [ ^maxSize := 20 ]].
		[MoveXbrRR]			-> [^maxSize := 4].
		[MoveRXbrR]			-> [^maxSize := 4].
		[MoveXwrRR]			-> [^maxSize := 4].
		[MoveRXwrR]			-> [^maxSize := 4].
		[PopR]					-> [^maxSize := 4].
		[PushR]					-> [^maxSize := 4].
		[PushCw]				-> [^maxSize := 20].
		[PushCq]				-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 8]
											ifFalse: [maxSize := 20]].
		[PrefetchAw] 			-> [^maxSize := (self isAddressRelativeToVarBase: (operands at: 1))
													ifTrue: [4]
													ifFalse: [20]].
		"Conversion"
		[ConvertRRd]	-> [^maxSize := 4].


		}.
	^0 "to keep C compiler quiet"
