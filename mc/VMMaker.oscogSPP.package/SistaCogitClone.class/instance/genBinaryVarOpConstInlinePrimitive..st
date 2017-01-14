inline primitive generators
genBinaryVarOpConstInlinePrimitive: prim
	"Var op const version of inline binary inline primitives."
	"SistaV1: 248		11111000 	iiiiiiii		mjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjj * 256) m=1 means inlined primitive, no hard return after execution.
	 See EncoderForSistaV1's class comment and StackInterpreter>>#binaryInlinePrimitive:"
	<option: #SistaVM>
	| rr val untaggedVal |
	val := self ssTop constant.
	self ssPop: 1.
	rr := self allocateRegForStackEntryAt: 0.
	self ssTop popToReg: rr.
	self ssPop: 1.
	untaggedVal := val - objectMemory smallIntegerTag.
	prim caseOf: {
		"0 through 6, +, -, *, /, //, \\, quo:, SmallInteger op SmallInteger => SmallInteger, no overflow"
		[0]	->	[self AddCq: untaggedVal R: rr].
		[1]	->	[self SubCq: untaggedVal R: rr ].
		[2]	->	[self flag: 'could use MulCq:R'.
				 objectRepresentation genShiftAwaySmallIntegerTagsInScratchReg: rr.
				 self MoveCq: untaggedVal R: TempReg.
				 self MulR: TempReg R: rr.
				 objectRepresentation genSetSmallIntegerTagsIn: rr].

		"2016 through 2019, bitAnd:, bitOr:, bitXor, bitShift:, SmallInteger op SmallInteger => SmallInteger, no overflow"
		[16] -> [ self AndCq: val R: rr ].
		[17] -> [ self OrCq: val R: rr ].
		[18] -> [ self flag: 'could use XorCq:'.
				self XorCw: untaggedVal R: rr. ].

		"2032	through 2037, >, <, >=, <=. =, ~=, SmallInteger op SmallInteger => Boolean (flags?? then in jump bytecodes if ssTop is a flags value, just generate the instruction!!)"
		"CmpCqR is SubRCq so everything is reversed."
		[32] -> [ self CmpCq: val R: rr.
				self genBinaryInlineComparison: JumpGreater opFalse: JumpLessOrEqual destReg: rr ].
		[33] -> [ self CmpCq: val R: rr.
				self genBinaryInlineComparison: JumpLess opFalse: JumpGreaterOrEqual destReg: rr ].
		[34] -> [ self CmpCq: val R: rr.
				self genBinaryInlineComparison: JumpGreaterOrEqual opFalse: JumpLess destReg: rr ].
		[35] -> [ self CmpCq: val R: rr.
				self genBinaryInlineComparison: JumpLessOrEqual opFalse: JumpGreater destReg: rr ].
		[36] -> [ self CmpCq: val R: rr.
				self genBinaryInlineComparison: JumpZero opFalse: JumpNonZero destReg: rr ].
		[37] -> [ self CmpCq: val R: rr.
				self genBinaryInlineComparison: JumpNonZero opFalse: JumpZero destReg: rr ].

		"2064	through 2068, Pointer Object>>at:, Byte Object>>at:, Short16 Word Object>>at: LongWord32 Object>>at: Quad64Word Object>>at:. obj op 0-rel SmallInteger => oop"
		[64] ->	[objectRepresentation genLoadSlot: (objectMemory integerValueOf: val) - 1 sourceReg: rr destReg: rr].
		[65] ->	[self MoveCq: (objectMemory integerValueOf: val) + objectMemory baseHeaderSize - 1 R: TempReg.
				self MoveXbr: TempReg R: rr R: rr.
				objectRepresentation genConvertIntegerToSmallIntegerInReg: rr]

	}
	otherwise: [^EncounteredUnknownBytecode].
	self ssPushRegister: rr.
	^0