inline primitive generators
genBinaryVarOpConstInlinePrimitive: prim
	"Var op const version of inline binary inline primitives."
	"SistaV1: 248		11111000 	iiiiiiii		mjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjj * 256) m=1 means inlined primitive, no hard return after execution.
	 See EncoderForSistaV1's class comment and StackInterpreter>>#inlinePrimitiveBytecode:"
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
		[1]	->	[self SubCq: untaggedVal R: rr].
		[2]	->	[self flag: 'could use MulCq:R'.
				 objectRepresentation genShiftAwaySmallIntegerTagsInScratchReg: rr.
				 self MoveCq: (objectMemory integerValueOf: val) R: TempReg.
				 self MulR: TempReg R: rr.
				 objectRepresentation genAddSmallIntegerTagsTo: rr].

		"16 through 19, bitAnd:, bitOr:, bitXor, bitShift:, SmallInteger op SmallInteger => SmallInteger, no overflow"

		"32	through 37, >, <, >=, <=. =, ~=, SmallInteger op SmallInteger => Boolean (flags?? then in jump bytecodes if ssTop is a flags value, just generate the instruction!!)"

		"64	through 68, Pointer Object>>at:, Byte Object>>at:, Short16 Word Object>>at: LongWord32 Object>>at: Quad64Word Object>>at:. obj op 0-rel SmallInteger => oop"

		"80	through 84, Pointer Object>>at:put:, Byte Object>>at:put:, Short16 Word Object>>at:put: LongWord32 Object>>at:put: Quad64Word Object>>at:put:. obj op 0-rel SmallInteger => oop"

	}
	otherwise: [^EncounteredUnknownBytecode].
	self ssPushRegister: rr.
	^0