inline primitive generators
genTrinaryInlinePrimitive: prim
	"Unary inline primitives."
	"SistaV1: 248		11111000 	iiiiiiii		mjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjj * 256) m=1 means inlined primitive, no hard return after execution.
	 See EncoderForSistaV1's class comment and StackInterpreter>>#trinaryInlinePrimitive:"

	| ra1 ra2 rr adjust |
	"The store check requires rr to be ReceiverResultReg"
	self allocateThreeRegistersInto: [:rTop :rNext :rThird | ra2 := rTop. ra1 := rNext. rr := rThird ] thirdIsReceiver: prim = 0.
	self assert: (rr ~= ra1 and: [rr ~= ra2 and: [ra1 ~= ra2]]).
	self ssTop popToReg: ra2.
	self ssPop: 1.
	self ssTop popToReg: ra1.
	self ssPop: 1.
	self ssTop popToReg: rr.
	self ssPop: 1.
	objectRepresentation genConvertSmallIntegerToIntegerInReg: ra1.
	"Now: ra is the variable object, rr is long, TempReg holds the value to store."
	prim caseOf: {
		"0 - 1 pointerAt:put: and byteAt:Put:"
		[0] ->	[ adjust := (objectMemory baseHeaderSize >> objectMemory shiftForWord) - 1. "shift by baseHeaderSize and then move from 1 relative to zero relative"
				adjust ~= 0 ifTrue: [ self AddCq: adjust R: ra1. ]. 
				self MoveR: ra2 Xwr: ra1 R: rr.
				objectRepresentation genStoreCheckReceiverReg: rr valueReg: ra2 scratchReg: TempReg inFrame: true].
		[1] ->	[ objectRepresentation genConvertSmallIntegerToIntegerInReg: ra2.
				adjust := objectMemory baseHeaderSize - 1. "shift by baseHeaderSize and then move from 1 relative to zero relative"
				self AddCq: adjust R: ra1.
				self MoveR: ra2 Xbr: ra1 R: rr.
				objectRepresentation genConvertIntegerToSmallIntegerInReg: ra2. ]
	}
	otherwise: [^EncounteredUnknownBytecode].
	self ssPushRegister: ra2.
	^0