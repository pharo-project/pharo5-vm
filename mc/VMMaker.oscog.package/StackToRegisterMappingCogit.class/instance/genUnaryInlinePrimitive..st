inline primitive generators
genUnaryInlinePrimitive: prim
	"Unary inline primitives."
	"SistaV1: 248		11111000 	iiiiiiii		mjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjj * 256) m=1 means inlined primitive, no hard return after execution.
	 See EncoderForSistaV1's class comment and StackInterpreter>>#unaryInlinePrimitive:"
	| rcvrReg resultReg |
	self ssTop type = SSRegister
		ifTrue: [rcvrReg := self ssTop register]
		ifFalse:
			[(rcvrReg := backEnd availableRegisterOrNilFor: self liveRegisters) ifNil:
				[self ssAllocateRequiredReg:
					(rcvrReg := optStatus isReceiverResultRegLive
							ifTrue: [Arg0Reg]
							ifFalse: [ReceiverResultReg])]].
	self ssTop popToReg: rcvrReg.
	self ssPop: 1.
	(resultReg := backEnd availableRegisterOrNilFor: self liveRegisters) ifNil:
		[self ssFlushUpThroughRegister: rcvrReg].
	prim
		caseOf: {
			[1] ->	"01		unchecked pointer numSlots"
				[resultReg ifNil: [resultReg := rcvrReg].
				 objectRepresentation
					genGetNumSlotsOf: rcvrReg into: resultReg;
					genConvertIntegerToSmallIntegerInScratchReg: resultReg.
				 self ssPushRegister: resultReg].
			[3] ->	"03 unchecked byte numBytes"
				[resultReg ifNil: [resultReg := rcvrReg].
				 objectRepresentation
					genGetNumBytesOf: rcvrReg into: resultReg;
					genConvertIntegerToSmallIntegerInScratchReg: resultReg.
				 self ssPushRegister: resultReg].
				  }
		otherwise:
			[^EncounteredUnknownBytecode].
	^0