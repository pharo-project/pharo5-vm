generate machine code
computeMaximumSize
	"Because we don't use Thumb, each ARM instruction has 4 bytes. Some abstract opcodes need more than one instruction."
	
	(opcode between: FirstShortJump and: LastJump) ifTrue:
		[^maxSize := 16].
	
	opcode
		caseOf: {
			[Label]					-> [^maxSize := 0].
			[AlignmentNops]		-> [^maxSize := (operands at: 0) - 1].
			[MoveAwR]				-> [^maxSize := (self isAddressRelativeToVarBase: (operands at: 0))
														ifTrue: [4]
														ifFalse: [20]].
			[MoveCqR]				-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := 16]].
			[MoveCwR]				-> [^maxSize := 16].
			[MoveRAw]				-> [^maxSize := (self isAddressRelativeToVarBase: (operands at: 1))
														ifTrue: [4]
														ifFalse: [20]].
			[MoveRMwr]			-> [self is12BitValue: (operands at: 1)
											ifTrue: [ :u :i | ^maxSize := 4]
											ifFalse: [ ^maxSize := 20 ]].
			[MoveRMbr]				-> [self is12BitValue: (operands at: 1)
											ifTrue: [ :u :i | ^maxSize := 4]
											ifFalse: [ ^maxSize := 20 ]].
			[MoveMwrR]			-> [self is12BitValue: (operands at: 0)
											ifTrue: [ :u :i | ^maxSize := 4]
											ifFalse: [ ^maxSize := 20 ]].
			[MoveMbrR]				-> [self is12BitValue: (operands at: 0)
											ifTrue: [ :u :i | ^maxSize := 4]
											ifFalse: [ ^maxSize := 20 ]].
			[PrefetchAw] 			-> [^maxSize := (self isAddressRelativeToVarBase: (operands at: 1))
														ifTrue: [4]
														ifFalse: [20]].
			[Call]					-> [^maxSize := 20 "recomputed in #sizePCDependentInstruction."].
			[RetN]					-> [^(operands at: 0) = 0 
											ifTrue: [maxSize := 4]
											ifFalse: [maxSize := 8]].
			[CmpCqR]				-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := 20]].
			[AddCqR]				-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := 20]].
			[BICCqR]				-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := 20]].
			[SubCqR]				-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := 20]].
			[AndCqR]				-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := 20]].
			[AndCqRR]				-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := 20]].
			[OrCqR]					-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := 20]].
			[TstCqR]				-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := 20]].
			[XorCqR]				-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := 20]].
			[CmpCwR]				-> [^maxSize := 20].
			[AddCwR]				-> [^maxSize := 20].
			[SubCwR]				-> [^maxSize := 20].
			[AndCwR]				-> [^maxSize := 20].
			[OrCwR]				-> [^maxSize := 20].
			[XorCwR]				-> [^maxSize := 20].
			[JumpR]					-> [^maxSize := 4].
			[JumpFPEqual]			-> [^maxSize := 8].
			[JumpFPNotEqual]		-> [^maxSize := 8].
			[JumpFPLess]			-> [^maxSize := 8].
			[JumpFPGreaterOrEqual]-> [^maxSize := 8].
			[JumpFPGreater]		-> [^maxSize := 8].
			[JumpFPLessOrEqual]	-> [^maxSize := 8].
			[JumpFPOrdered]		-> [^maxSize := 8].
			[JumpFPUnordered]		-> [^maxSize := 8].
			[JumpLong]				-> [^maxSize := 20].
			[JumpLongZero]		-> [^maxSize := 20].
			[JumpLongNonZero]	-> [^maxSize := 20].
			[LoadEffectiveAddressMwrR]
									-> [^self rotateable8bitImmediate: (operands at: 0)
											ifTrue: [:r :i| maxSize := 4]
											ifFalse: [maxSize := 20]].
			[PushCw]				-> [^maxSize := 20].
		}
		otherwise: [^maxSize := 4].
	^4 "to keep C compiler quiet"
