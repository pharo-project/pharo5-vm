inline primitive generators
genBinaryVarOpVarInlinePrimitive: prim
	"Var op var version of binary inline primitives."
	"SistaV1: 248		11111000 	iiiiiiii		mjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjj * 256) m=1 means inlined primitive, no hard return after execution.
	 See EncoderForSistaV1's class comment and StackInterpreter>>#binaryInlinePrimitive:"
	<option: #SistaVM>
	| ra rr adjust |
	self allocateRegForStackTopTwoEntriesInto: [:rTop :rNext | ra := rTop. rr := rNext ].
	self ssTop popToReg: ra.
	self ssPop: 1.
	self ssTop popToReg: rr.
	self ssPop: 1.
	prim caseOf: {
		"0 through 6, +, -, *, /, //, \\, quo:, SmallInteger op SmallInteger => SmallInteger, no overflow"
		[0]	->	[objectRepresentation genRemoveSmallIntegerTagsInScratchReg: ra.
				 self AddR: ra R: rr].
		[1]	->	[self SubR: ra R: rr.
				 objectRepresentation genAddSmallIntegerTagsTo: rr].
		[2]	->	[self genShiftAwaySmallIntegerTagsInScratchReg: rr.
				 self genRemoveSmallIntegerTagsInScratchReg: ra.
				 self MulR: ra R: rr.
				 self genSetSmallIntegerTagsIn: rr].

		"2016 through 2019, bitAnd:, bitOr:, bitXor, bitShift:, SmallInteger op SmallInteger => SmallInteger, no overflow"
		[16] -> [ self AndR: ra R: rr ].
		[17] -> [ self OrR: ra R: rr ].
		[18] -> [objectRepresentation genRemoveSmallIntegerTagsInScratchReg: ra. 
				self XorR: ra R: rr. ].


		"2032	through 2037, >, <, >=, <=. =, ~=, SmallInteger op SmallInteger => Boolean (flags?? then in jump bytecodes if ssTop is a flags value, just generate the instruction!!)"
		"CmpCqR is SubRCq so everything is reversed."
		[32] -> [ self CmpR: ra R: rr.
				self genBinaryInlineComparison: JumpGreater opFalse: JumpLessOrEqual destReg: rr ].
		[33] -> [ self CmpR: ra R: rr.
				self genBinaryInlineComparison: JumpLess opFalse: JumpGreaterOrEqual destReg: rr ].
		[34] -> [ self CmpR: ra R: rr.
				self genBinaryInlineComparison: JumpGreaterOrEqual opFalse: JumpLess destReg: rr ].
		[35] -> [ self CmpR: ra R: rr.
				self genBinaryInlineComparison: JumpLessOrEqual opFalse: JumpGreater destReg: rr ].
		[36] -> [ self CmpR: ra R: rr.
				self genBinaryInlineComparison: JumpZero opFalse: JumpNonZero destReg: rr ].
		[37] -> [ self CmpR: ra R: rr.
				self genBinaryInlineComparison: JumpNonZero opFalse: JumpZero destReg: rr ].

		"2064	through 2068, Pointer Object>>at:, Byte Object>>at:, Short16 Word Object>>at: LongWord32 Object>>at: Quad64Word Object>>at:. obj op 0-rel SmallInteger => oop"
		[64] ->	[objectRepresentation genConvertSmallIntegerToIntegerInReg: ra.
				adjust := (objectMemory baseHeaderSize >> objectMemory shiftForWord) - 1. "shift by baseHeaderSize and then move from 1 relative to zero relative"
				adjust ~= 0 ifTrue: [ self AddCq: adjust R: ra. ]. 
				self MoveXwr: ra R: rr R: rr ].
		[65] ->	[objectRepresentation genConvertSmallIntegerToIntegerInReg: ra.
				adjust := objectMemory baseHeaderSize - 1. "shift by baseHeaderSize and then move from 1 relative to zero relative"
				self AddCq: adjust R: ra.
				self MoveXbr: ra R: rr R: rr.
				objectRepresentation genConvertIntegerToSmallIntegerInReg: rr]

	}
	otherwise: [^EncounteredUnknownBytecode].
	self ssPushRegister: rr.
	^0