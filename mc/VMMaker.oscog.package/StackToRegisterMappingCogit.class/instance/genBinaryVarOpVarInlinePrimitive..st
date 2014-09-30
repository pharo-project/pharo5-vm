inline primitive generators
genBinaryVarOpVarInlinePrimitive: prim
	"Var op var version of binary inline primitives."
	"SistaV1: 248		11111000 	iiiiiiii		mjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjj * 256) m=1 means inlined primitive, no hard return after execution.
	 See EncoderForSistaV1's class comment and StackInterpreter>>#binaryInlinePrimitive:"
	| ra rr |
	(rr := backEnd availableRegisterOrNilFor: self liveRegisters) ifNil:
		[self ssAllocateRequiredReg:
			(rr := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].
	(ra := backEnd availableRegisterOrNilFor: (self liveRegisters bitOr: (self registerMaskFor: rr))) ifNil:
		[self ssAllocateRequiredReg: (ra := Arg1Reg)].
	(rr = ReceiverResultReg or: [ra = ReceiverResultReg]) ifTrue:
		[optStatus isReceiverResultRegLive: false].
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
		[2]	->	[objectRepresentation genRemoveSmallIntegerTagsInScratchReg: rr.
				 objectRepresentation genShiftAwaySmallIntegerTagsInScratchReg: ra.
				 self MulR: ra R: rr.
				 objectRepresentation genAddSmallIntegerTagsTo: rr].

		"2016 through 2019, bitAnd:, bitOr:, bitXor, bitShift:, SmallInteger op SmallInteger => SmallInteger, no overflow"

		"2032	through 2037, >, <, >=, <=. =, ~=, SmallInteger op SmallInteger => Boolean (flags?? then in jump bytecodes if ssTop is a flags value, just generate the instruction!!)"

		"2064	through 2068, Pointer Object>>at:, Byte Object>>at:, Short16 Word Object>>at: LongWord32 Object>>at: Quad64Word Object>>at:. obj op 0-rel SmallInteger => oop"

	}
	otherwise: [^EncounteredUnknownBytecode].
	self ssPushRegister: rr.
	^0