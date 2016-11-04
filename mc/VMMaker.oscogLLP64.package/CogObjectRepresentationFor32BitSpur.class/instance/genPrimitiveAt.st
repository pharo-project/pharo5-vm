primitive generators
genPrimitiveAt
	| formatReg nSlotsOrBytesReg convertToIntAndReturn methodInBounds
	  jumpNotIndexable jumpImmediate jumpBadIndex
	  jumpIsBytes jumpIsShorts jumpIsWords jumpIsMethod
	  jumpWordTooBig jumpIsArray jumpHasFixedFields jumpIsContext
	  jumpBytesOutOfBounds jumpShortsOutOfBounds jumpWordsOutOfBounds
	  jumpMethodOutOfBounds jumpArrayOutOfBounds jumpFixedFieldsOutOfBounds |
	"c.f. StackInterpreter>>stSizeOf: SpurMemoryManager>>lengthOf:format: fixedFieldsOf:format:length:"
	<var: #jumpIsBytes type: #'AbstractInstruction *'>
	<var: #jumpIsShorts type: #'AbstractInstruction *'>
	<var: #jumpIsMethod type: #'AbstractInstruction *'>
	<var: #jumpBadIndex type: #'AbstractInstruction *'>
	<var: #jumpIsContext type: #'AbstractInstruction *'>
	<var: #jumpImmediate type: #'AbstractInstruction *'>
	<var: #methodInBounds type: #'AbstractInstruction *'>
	<var: #jumpWordTooBig type: #'AbstractInstruction *'>
	<var: #jumpNotIndexable type: #'AbstractInstruction *'>
	<var: #jumpHasFixedFields type: #'AbstractInstruction *'>
	<var: #convertToIntAndReturn type: #'AbstractInstruction *'>
	<var: #jumpArrayOutOfBounds type: #'AbstractInstruction *'>
	<var: #jumpBytesOutOfBounds type: #'AbstractInstruction *'>
	<var: #jumpShortsOutOfBounds type: #'AbstractInstruction *'>
	<var: #jumpWordsOutOfBounds type: #'AbstractInstruction *'>
	<var: #jumpMethodOutOfBounds type: #'AbstractInstruction *'>
	<var: #jumpFixedFieldsOutOfBounds type: #'AbstractInstruction *'>

	nSlotsOrBytesReg := ClassReg.

	cogit genLoadArgAtDepth: 0 into: Arg0Reg.
	jumpImmediate := self genJumpImmediate: ReceiverResultReg.
	cogit MoveR: Arg0Reg R: Arg1Reg.
	jumpBadIndex := self genJumpNotSmallInteger: Arg0Reg scratchReg: TempReg.
	self genConvertSmallIntegerToIntegerInReg: Arg1Reg.
	cogit SubCq: 1 R: Arg1Reg. "1-rel => 0-rel"

	"formatReg := self formatOf: ReceiverResultReg"
	self genGetFormatOf: ReceiverResultReg
		into: (formatReg := SendNumArgsReg)
		leastSignificantHalfOfBaseHeaderIntoScratch: TempReg.

	self genGetNumSlotsOf: ReceiverResultReg into: nSlotsOrBytesReg.

	"dispatch on format in a combination of highest dynamic frequency order first and convenience.
		  0 = 0 sized objects (UndefinedObject True False et al)
		  1 = non-indexable objects with inst vars (Point et al)
		  2 = indexable objects with no inst vars (Array et al)
		  3 = indexable objects with inst vars (MethodContext AdditionalMethodState et al)
		  4 = weak indexable objects with inst vars (WeakArray et al)
		  5 = weak non-indexable objects with inst vars (ephemerons) (Ephemeron)
		  6 unused, reserved for exotic pointer objects?
		  7 Forwarded Object, 1st field is pointer, rest of fields are ignored
		  8 unused, reserved for exotic non-pointer objects?
		  9 (?) 64-bit indexable
		10 - 11 32-bit indexable
		12 - 15 16-bit indexable
		16 - 23 byte indexable
		24 - 31 compiled method"
	cogit CmpCq: objectMemory firstByteFormat R: formatReg.
	jumpIsBytes := cogit JumpAboveOrEqual: 0.
					cogit CmpCq: objectMemory arrayFormat R: formatReg.
	jumpIsArray := cogit JumpZero: 0.
	jumpNotIndexable := cogit JumpBelow: 0.
					cogit CmpCq: objectMemory weakArrayFormat R: formatReg.
	jumpHasFixedFields := cogit JumpBelowOrEqual: 0.
					cogit CmpCq: objectMemory firstShortFormat R: formatReg.
	jumpIsShorts := cogit JumpAboveOrEqual: 0.
					cogit CmpCq: objectMemory firstLongFormat R: formatReg.
	jumpIsWords := cogit JumpAboveOrEqual: 0.
	"For now ignore 64-bit indexability."
	jumpNotIndexable jmpTarget: cogit Label.
	jumpNotIndexable := cogit Jump: 0.

	jumpIsArray jmpTarget:
		(cogit CmpR: Arg1Reg R: nSlotsOrBytesReg).
	jumpArrayOutOfBounds := cogit JumpBelowOrEqual: 0.	
	cogit AddCq: objectMemory baseHeaderSize >> objectMemory shiftForWord R: Arg1Reg.
	cogit MoveXwr: Arg1Reg R: ReceiverResultReg R: ReceiverResultReg.
	cogit genPrimReturn.

	jumpIsBytes jmpTarget:
		(cogit LogicalShiftLeftCq: objectMemory shiftForWord R: nSlotsOrBytesReg).
		cogit AndCq: objectMemory wordSize - 1 R: formatReg R: TempReg.
		cogit SubR: TempReg R: nSlotsOrBytesReg;
		CmpR: Arg1Reg R: nSlotsOrBytesReg.
	jumpBytesOutOfBounds := cogit JumpBelowOrEqual: 0.
	cogit CmpCq: objectMemory firstCompiledMethodFormat R: formatReg.
	jumpIsMethod := cogit JumpAboveOrEqual: 0.
	methodInBounds :=
	(cogit AddCq: objectMemory baseHeaderSize R: Arg1Reg).
	cogit backEnd byteReadsZeroExtend
		ifTrue:
			[cogit MoveXbr: Arg1Reg R: ReceiverResultReg R: ReceiverResultReg]
		ifFalse:
			[cogit "formatReg already contains a value <= 16r1f, so no need to zero it"
				MoveXbr: Arg1Reg R: ReceiverResultReg R: formatReg;
				MoveR: formatReg R: ReceiverResultReg].
	convertToIntAndReturn := cogit Label.
	self genConvertIntegerToSmallIntegerInReg: ReceiverResultReg.
	cogit genPrimReturn.

	jumpIsShorts jmpTarget:
		(cogit LogicalShiftLeftCq: objectMemory shiftForWord - 1 R: nSlotsOrBytesReg).
		cogit AndCq: 1 R: formatReg.
		cogit SubR: formatReg R: nSlotsOrBytesReg;
		CmpR: Arg1Reg R: nSlotsOrBytesReg.
	jumpShortsOutOfBounds := cogit JumpBelowOrEqual: 0.
	cogit AddR: Arg1Reg R: ReceiverResultReg.
	cogit AddR: Arg1Reg R: ReceiverResultReg.
	cogit MoveM16: objectMemory baseHeaderSize r: ReceiverResultReg R: ReceiverResultReg.
	cogit Jump: convertToIntAndReturn.

	jumpIsWords jmpTarget:
		(cogit CmpR: Arg1Reg R: nSlotsOrBytesReg).
	jumpWordsOutOfBounds := cogit JumpBelowOrEqual: 0.
	cogit AddCq: objectMemory baseHeaderSize >> objectMemory shiftForWord R: Arg1Reg.
	cogit MoveXwr: Arg1Reg R: ReceiverResultReg R: TempReg.
	jumpWordTooBig := self jumpNotSmallIntegerUnsignedValueInRegister: TempReg.
	cogit MoveR: TempReg R: ReceiverResultReg.
	cogit Jump: convertToIntAndReturn.

	jumpHasFixedFields jmpTarget:
		(cogit AndCq: objectMemory classIndexMask R: TempReg).
	cogit MoveR: TempReg R: formatReg.
	cogit CmpCq: ClassMethodContextCompactIndex R: TempReg.
	jumpIsContext := cogit JumpZero: 0.
	cogit PushR: nSlotsOrBytesReg.
	self genGetClassObjectOfClassIndex: formatReg into: nSlotsOrBytesReg scratchReg: TempReg.
	self genLoadSlot: InstanceSpecificationIndex sourceReg: nSlotsOrBytesReg destReg: formatReg.
	cogit PopR: nSlotsOrBytesReg.
	self genConvertSmallIntegerToIntegerInReg: formatReg.
	cogit
		AndCq: objectMemory fixedFieldsOfClassFormatMask R: formatReg;
		SubR: formatReg R: nSlotsOrBytesReg;
		CmpR: Arg1Reg R: nSlotsOrBytesReg.
	jumpFixedFieldsOutOfBounds := cogit JumpBelowOrEqual: 0.
	"index is (formatReg (fixed fields) + Arg1Reg (0-rel index)) * wordSize + baseHeaderSize"
	cogit AddR: formatReg R: Arg1Reg.
	cogit AddCq: objectMemory baseHeaderSize >> objectMemory shiftForWord R: Arg1Reg.
	cogit MoveXwr: Arg1Reg R: ReceiverResultReg R: ReceiverResultReg.
	cogit genPrimReturn.

	jumpIsMethod jmpTarget: cogit Label.
	"Now check that the index is beyond the method's literals..."
	self getLiteralCountOf: ReceiverResultReg plusOne: true inBytes: true into: nSlotsOrBytesReg scratch: TempReg.
	cogit CmpR: Arg1Reg R: nSlotsOrBytesReg.
	cogit JumpBelow: methodInBounds.
	jumpMethodOutOfBounds := cogit Jump: 0.

	jumpWordTooBig jmpTarget:
	(jumpFixedFieldsOutOfBounds jmpTarget:
	(jumpArrayOutOfBounds jmpTarget:
	(jumpBytesOutOfBounds jmpTarget:
	(jumpMethodOutOfBounds jmpTarget:
	(jumpShortsOutOfBounds jmpTarget:
	(jumpWordsOutOfBounds jmpTarget:
	(jumpNotIndexable jmpTarget:
	(jumpIsContext jmpTarget:
	(jumpBadIndex jmpTarget:
	(jumpImmediate jmpTarget: cogit Label)))))))))).

	^0 "Can't be complete because of contexts."