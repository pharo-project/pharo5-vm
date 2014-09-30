inline primitive generators
genBinaryConstOpVarInlinePrimitive: prim
	"Const op var version of binary inline primitives."
	"SistaV1: 248		11111000 	iiiiiiii		mjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjj * 256) m=1 means inlined primitive, no hard return after execution.
	 See EncoderForSistaV1's class comment and StackInterpreter>>#binaryInlinePrimitive:"
	| ra val untaggedVal |
	(ra := backEnd availableRegisterOrNilFor: self liveRegisters) ifNil:
		[self ssAllocateRequiredReg:
			(ra := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].
	ra = ReceiverResultReg ifTrue:
		[optStatus isReceiverResultRegLive: false].
	self ssTop popToReg: ra.
	self ssPop: 1.
	val := self ssTop constant.
	self ssPop: 1.
	untaggedVal := val - objectMemory smallIntegerTag.
	prim caseOf: {
		"0 through 6, +, -, *, /, //, \\, quo:, SmallInteger op SmallInteger => SmallInteger, no overflow"
		[0]	->	[self AddCq: untaggedVal R: ra].
		[1]	->	[self SubCq: untaggedVal R: ra].
		[2]	->	[objectRepresentation genRemoveSmallIntegerTagsInScratchReg: ra.
				 self MoveCq: (objectMemory integerValueOf: val) R: TempReg.
				 self MulR: TempReg R: ra.
				 objectRepresentation genAddSmallIntegerTagsTo: ra].

		"2016 through 2019, bitAnd:, bitOr:, bitXor, bitShift:, SmallInteger op SmallInteger => SmallInteger, no overflow"

		"2032	through 2037, >, <, >=, <=. =, ~=, SmallInteger op SmallInteger => Boolean (flags?? then in jump bytecodes if ssTop is a flags value, just generate the instruction!!)"

		"2064	through 2068, Pointer Object>>at:, Byte Object>>at:, Short16 Word Object>>at: LongWord32 Object>>at: Quad64Word Object>>at:. obj op 0-rel SmallInteger => oop"

	}
	otherwise: [^EncounteredUnknownBytecode].
	self ssPushRegister: ra.
	^0