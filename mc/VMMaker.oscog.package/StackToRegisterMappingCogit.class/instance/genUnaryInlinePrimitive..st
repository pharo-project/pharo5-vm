inline primitive generators
genUnaryInlinePrimitive: prim
	"Unary inline primitives."
	"SistaV1: 248		11111000 	iiiiiiii		mjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjj * 256) m=1 means inlined primitive, no hard return after execution.
	 See EncoderForSistaV1's class comment and StackInterpreter>>#unaryInlinePrimitive:"
	| rcvrReg resultReg |
	rcvrReg := self allocateOneRegister.
	resultReg := self allocateRegisterNotConflictingWith: (self registerMaskFor: rcvrReg).
	self ssTop popToReg: rcvrReg.
	self ssPop: 1.
	prim
		caseOf: {
					"00		unchecked class"
			[1] ->	"01		unchecked pointer numSlots"
				[objectRepresentation
					genGetNumSlotsOf: rcvrReg into: resultReg;
					genConvertIntegerToSmallIntegerInReg: resultReg].
					"02		unchecked pointer basicSize"
			[3] ->	"03		unchecked byte numBytes"
				[objectRepresentation
					genGetNumBytesOf: rcvrReg into: resultReg;
					genConvertIntegerToSmallIntegerInReg: resultReg].
					"04		unchecked short16Type format numShorts"
					"05		unchecked word32Type format numWords"
					"06		unchecked doubleWord64Type format numDoubleWords"
				  }
		otherwise:
			[^EncounteredUnknownBytecode]..
	self ssPushRegister: resultReg.
	^0