inline primitive generators
genBinaryVarOpConstInlinePrimitive: prim
	"Var op const version of inline binary inline primitives."
	"SistaV1: 248		11111000 	iiiiiiii		mjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjj * 256) m=1 means inlined primitive, no hard return after execution.
	 See EncoderForSistaV1's class comment and StackInterpreter>>#binaryInlinePrimitive:"
	| rr val untaggedVal |
	(rr := backEnd availableRegisterOrNilFor: self liveRegisters) ifNil:
		[self ssAllocateRequiredReg:
			(rr := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].
	rr = ReceiverResultReg ifTrue:
		[optStatus isReceiverResultRegLive: false].
	val := self ssTop constant.
	self ssPop: 1.
	self ssTop popToReg: rr.
	self ssPop: 1.
	untaggedVal := val - objectMemory smallIntegerTag.
	prim caseOf: {
		"0 through 6, +, -, *, /, //, \\, quo:, SmallInteger op SmallInteger => SmallInteger, no overflow"
		[0]	->	[self AddCq: untaggedVal R: rr].
		[1]	->	[self SubCq: untaggedVal R: rr ].
		[2]	->	[self flag: 'could use MulCq:R'.
				 objectRepresentation genShiftAwaySmallIntegerTagsInScratchReg: rr.
				 self MoveCq: (objectMemory integerValueOf: val) R: TempReg.
				 self MulR: TempReg R: rr.
				 objectRepresentation genAddSmallIntegerTagsTo: rr].

		"2016 through 2019, bitAnd:, bitOr:, bitXor, bitShift:, SmallInteger op SmallInteger => SmallInteger, no overflow"

		"2032	through 2037, >, <, >=, <=. =, ~=, SmallInteger op SmallInteger => Boolean (flags?? then in jump bytecodes if ssTop is a flags value, just generate the instruction!!)
		Here the comparison is reversed (cst on the left, reg on the right) so I inverted opTrue and opFalse"
		[32] -> [ self CmpCq: val R: rr.
				self genBinaryInlineComparison: JumpLess opFalse: JumpGreater destReg: rr ].
		[33] -> [ self CmpCq: val R: rr.
				self genBinaryInlineComparison: JumpGreater opFalse: JumpLess destReg: rr ].
		[34] -> [ self CmpCq: val R: rr.
				self genBinaryInlineComparison: JumpLessOrEqual opFalse: JumpGreaterOrEqual destReg: rr ].
		[35] -> [ self CmpCq: val R: rr.
				self genBinaryInlineComparison: JumpGreaterOrEqual opFalse: JumpLessOrEqual destReg: rr ].
		[36] -> [ self CmpCq: val R: rr.
				self genBinaryInlineComparison: JumpNonZero opFalse: JumpZero destReg: rr ].
		[37] -> [ self CmpCq: val R: rr.
				self genBinaryInlineComparison: JumpZero opFalse: JumpNonZero destReg: rr ].

		"2064	through 2068, Pointer Object>>at:, Byte Object>>at:, Short16 Word Object>>at: LongWord32 Object>>at: Quad64Word Object>>at:. obj op 0-rel SmallInteger => oop"
		[64] ->	[self genConvertSmallIntegerToIntegerInReg: rr.
				self MoveCq: (objectMemory integerValueOf: val) + (objectMemory baseHeaderSize >> objectMemory shiftForWord) - 1 R: TempReg.
				self MoveXwr: TempReg R: rr R: rr ].
		[65] ->	[self genConvertSmallIntegerToIntegerInReg: rr.
				self MoveCq: (objectMemory integerValueOf: val) + objectMemory baseHeaderSize - 1 R: TempReg.
				self MoveXbr: TempReg R: rr R: rr ]

	}
	otherwise: [^EncounteredUnknownBytecode].
	self ssPushRegister: rr.
	^0