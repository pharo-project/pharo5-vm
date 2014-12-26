inline primitive generators
genTrinaryInlinePrimitive: prim
	"Unary inline primitives."
	"SistaV1: 248		11111000 	iiiiiiii		mjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjj * 256) m=1 means inlined primitive, no hard return after execution.
	 See EncoderForSistaV1's class comment and StackInterpreter>>#trinaryInlinePrimitive:"

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
	self ssTop popToReg: TempReg.
	self ssPop: 1.
	self ssTop popToReg: ra.
	self ssPop: 1.
	self ssTop popToReg: rr.
	self ssPop: 1.
	self ssPushRegister: TempReg.
	self genConvertSmallIntegerToIntegerInReg: ra.
	"Now: ra is the variable object, rr is long, TempReg holds the value to store."
	prim caseOf: {
		"0 - 1 pointerAt:put: and byteAt:Put:"
		[0] ->	[ self MoveR: TempReg Xwr: ra R: rr ].
		[1] ->	[ self genConvertSmallIntegerToIntegerInReg: TempReg.
				self MoveR: TempReg Xbr: ra R: rr ]
	}
	otherwise: [^EncounteredUnknownBytecode].
	^0