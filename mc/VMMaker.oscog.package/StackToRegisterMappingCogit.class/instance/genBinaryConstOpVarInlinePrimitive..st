inline primitive generators
genBinaryConstOpVarInlinePrimitive: prim
	"Const op var version of binary inline primitives."
	"SistaV1: 248		11111000 	iiiiiiii		mjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjj * 256) m=1 means inlined primitive, no hard return after execution.
	 See EncoderForSistaV1's class comment and StackInterpreter>>#binaryInlinePrimitive:"
	| ra val untaggedVal adjust |
	ra := self allocateOneRegister.
	self ssTop popToReg: ra.
	self ssPop: 1.
	val := self ssTop constant.
	self ssPop: 1.
	untaggedVal := val - objectMemory smallIntegerTag.
	prim caseOf: {
		"0 through 6, +, -, *, /, //, \\, quo:, SmallInteger op SmallInteger => SmallInteger, no overflow"
		[0]	->	[self AddCq: untaggedVal R: ra].
		[1]	->	[self MoveCq: val R: TempReg.
				 self SubR: ra R: TempReg.
				 objectRepresentation genAddSmallIntegerTagsTo: TempReg.
				 self MoveR: TempReg R: ra].
		[2]	->	[objectRepresentation genRemoveSmallIntegerTagsInScratchReg: ra.
				 self MoveCq: (objectMemory integerValueOf: val) R: TempReg.
				 self MulR: TempReg R: ra.
				 objectRepresentation genAddSmallIntegerTagsTo: ra].

		"2016 through 2019, bitAnd:, bitOr:, bitXor, bitShift:, SmallInteger op SmallInteger => SmallInteger, no overflow"

		"2032	through 2037, >, <, >=, <=. =, ~=, SmallInteger op SmallInteger => Boolean (flags?? then in jump bytecodes if ssTop is a flags value, just generate the instruction!!)"
		[32] -> [ self CmpCq: val R: ra.
				self genBinaryInlineComparison: JumpGreater opFalse: JumpLess destReg: ra ].
		[33] -> [ self CmpCq: val R: ra.
				self genBinaryInlineComparison: JumpLess opFalse: JumpGreater destReg: ra ].
		[34] -> [ self CmpCq: val R: ra.
				self genBinaryInlineComparison: JumpGreaterOrEqual opFalse: JumpLessOrEqual destReg: ra ].
		[35] -> [ self CmpCq: val R: ra.
				self genBinaryInlineComparison: JumpLessOrEqual opFalse: JumpGreaterOrEqual destReg: ra ].
		[36] -> [ self CmpCq: val R: ra.
				self genBinaryInlineComparison: JumpZero opFalse: JumpNonZero destReg: ra ].
		[37] -> [ self CmpCq: val R: ra.
				self genBinaryInlineComparison: JumpNonZero opFalse: JumpZero destReg: ra ].

		"2064	through 2068, Pointer Object>>at:, Byte Object>>at:, Short16 Word Object>>at: LongWord32 Object>>at: Quad64Word Object>>at:. obj op 0-rel SmallInteger => oop"
		[64] ->	[objectRepresentation genConvertSmallIntegerToIntegerInReg: ra.
				adjust := (objectMemory baseHeaderSize >> objectMemory shiftForWord) - 1. "shift by baseHeaderSize and then move from 1 relative to zero relative"
				adjust ~= 0 ifTrue: [ self AddCq: adjust R: ra. ]. 
				self annotate: (self MoveCw: val R: TempReg) objRef: val.
				self MoveXwr: ra R: TempReg R: ra].
		[65] ->	[objectRepresentation genConvertSmallIntegerToIntegerInReg: ra.
				adjust := objectMemory baseHeaderSize - 1. "shift by baseHeaderSize and then move from 1 relative to zero relative"
				self AddCq: adjust R: ra.
				self annotate: (self MoveCw: val R: TempReg) objRef: val.
				self MoveXbr: ra R: TempReg R: ra]

	}
	otherwise: [^EncounteredUnknownBytecode].
	self ssPushRegister: ra.
	^0