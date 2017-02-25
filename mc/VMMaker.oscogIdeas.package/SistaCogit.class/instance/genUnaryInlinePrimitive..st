inline primitive generators
genUnaryInlinePrimitive: prim
	"Unary inline primitives."
	"SistaV1: 248		11111000 	iiiiiiii		mjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjj * 256) m=1 means inlined primitive, no hard return after execution.
	 See EncoderForSistaV1's class comment and StackInterpreter>>#unaryInlinePrimitive:"
	| rcvrReg resultReg |
	rcvrReg := self allocateRegForStackEntryAt: 0.
	resultReg := self allocateRegNotConflictingWith: (self registerMaskFor: rcvrReg).
	prim
		caseOf: {
					"00		unchecked class"
			[1] ->	"01		unchecked pointer numSlots"
				[self ssTop popToReg: rcvrReg.
				 self ssPop: 1.
				 objectRepresentation
					genGetNumSlotsOf: rcvrReg into: resultReg;
					genConvertIntegerToSmallIntegerInReg: resultReg].
					"02		unchecked pointer basicSize"
			[3] ->	"03		unchecked byte numBytes"
				[self ssTop popToReg: rcvrReg.
				 self ssPop: 1.
				 objectRepresentation
					genGetNumBytesOf: rcvrReg into: resultReg;
					genConvertIntegerToSmallIntegerInReg: resultReg].
					"04		unchecked short16Type format numShorts"
					"05		unchecked word32Type format numWords"
					"06		unchecked doubleWord64Type format numDoubleWords"
			[11] ->	"11		unchecked fixed pointer basicNew"
				[self ssTop type ~= SSConstant ifTrue:
					[^EncounteredUnknownBytecode].
				 (objectRepresentation
					genGetInstanceOf: self ssTop constant
						into: resultReg
							initializingIf: self extBSpecifiesInitializeInstance) ~= 0 ifTrue:
					[^ShouldNotJIT]. "e.g. bad class"
				 self ssPop: 1] .
			[20] ->	"20 	identityHash"
				[objectRepresentation genGetIdentityHash: rcvrReg resultReg: resultReg.
				 self ssPop: 1] .
					"21		identityHash (SmallInteger)"
					"22		identityHash (Character)"
					"23		identityHash (SmallFloat64)"
					"24		identityHash (Behavior)"
					"30 	immediateAsInteger (Character)
					 31 	immediateAsInteger (SmallFloat64)"
			[30] -> 
				[self ssTop popToReg: resultReg.
				 objectRepresentation genConvertCharacterToSmallIntegerInReg: resultReg.
				 self ssPop: 1]
				  }
				
		otherwise:
			[^EncounteredUnknownBytecode].
	extB := 0.
	numExtB := 0.
	self ssPushRegister: resultReg.
	^0