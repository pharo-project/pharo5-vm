inline primitive generators
genBinaryVarOpVarInlinePrimitive: prim
	"Var op var version of binary inline primitives."
	"SistaV1: 248		11111000 	iiiiiiii		mjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjj * 256) m=1 means inlined primitive, no hard return after execution.
	 See EncoderForSistaV1's class comment and StackInterpreter>>#inlinePrimitiveBytecode:"
	| ra rr |
	(rr := backEnd availableRegisterOrNilFor: self liveRegisters) ifNil:
		[self ssAllocateRequiredReg:
			(rr := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].
	(ra := backEnd availableRegisterOrNilFor: (self liveRegisters bitOr: (self registerMaskFor: rr))) ifNil:
		[self ssAllocateRequiredReg: (rr := Arg1Reg)].
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

		"16 through 19, bitAnd:, bitOr:, bitXor, bitShift:, SmallInteger op SmallInteger => SmallInteger, no overflow"

		"32	through 37, >, <, >=, <=. =, ~=, SmallInteger op SmallInteger => Boolean (flags?? then in jump bytecodes if ssTop is a flags value, just generate the instruction!!)"

		"64	through 68, Pointer Object>>at:, Byte Object>>at:, Short16 Word Object>>at: LongWord32 Object>>at: Quad64Word Object>>at:. obj op 0-rel SmallInteger => oop"

		"80	through 84, Pointer Object>>at:put:, Byte Object>>at:put:, Short16 Word Object>>at:put: LongWord32 Object>>at:put: Quad64Word Object>>at:put:. obj op 0-rel SmallInteger => oop"

	}
	otherwise: [^EncounteredUnknownBytecode].
	self ssPushRegister: rr.
	^0