primitive generators
genInnerPrimitiveAtPut: retNoffset
	"Implement the guts of primitiveAtPut"
	| formatReg jumpImmediate jumpBadIndex
	  jumpSmallSize jumpNotIndexablePointers jumpNotIndexableBits
	  jumpIsContext jumpIsCompiledMethod jumpIsBytes jumpHasFixedFields
	  jumpArrayOutOfBounds jumpFixedFieldsOutOfBounds
	  jumpWordsOutOfBounds jumpBytesOutOfBounds jumpBytesOutOfRange
	  jumpNonSmallIntegerValue jumpShortsUnsupported jumpNotPointers
	  |
	<inline: true>
	"c.f. StackInterpreter>>stSizeOf: SpurMemoryManager>>lengthOf:format: fixedFieldsOf:format:length:"
	<var: #jumpIsBytes type: #'AbstractInstruction *'>
	<var: #jumpBadIndex type: #'AbstractInstruction *'>
	<var: #jumpSmallSize type: #'AbstractInstruction *'>
	<var: #jumpIsContext type: #'AbstractInstruction *'>
	<var: #jumpImmediate type: #'AbstractInstruction *'>
	<var: #jumpHasFixedFields type: #'AbstractInstruction *'>
	<var: #jumpNotIndexableBits type: #'AbstractInstruction *'>
	<var: #jumpArrayOutOfBounds type: #'AbstractInstruction *'>
	<var: #jumpBytesOutOfBounds type: #'AbstractInstruction *'>
	<var: #jumpShortsUnsupported type: #'AbstractInstruction *'>
	<var: #jumpWordsOutOfBounds type: #'AbstractInstruction *'>
	<var: #jumpNotIndexablePointers type: #'AbstractInstruction *'>

	cogit MoveR: ReceiverResultReg R: TempReg.
	jumpImmediate := self genJumpImmediateInScratchReg: TempReg.
	cogit MoveR: Arg0Reg R: TempReg.
	jumpBadIndex := self genJumpNotSmallIntegerInScratchReg: TempReg.
	self genConvertSmallIntegerToIntegerInReg: Arg0Reg.
	cogit SubCq: 1 R: Arg0Reg. "1-rel => 0-rel"

	"formatReg := self formatOf: ReceiverResultReg"
	self genGetFormatOf: ReceiverResultReg
		into: (formatReg := SendNumArgsReg)
		leastSignificantHalfOfBaseHeaderIntoScratch: TempReg.

	"get numSlots into ClassReg."
	cogit MoveCq: 0 R: ClassReg. "N.B. MoveMb:r:R: does not zero other bits"
	cogit MoveMb: 7 r: ReceiverResultReg R: ClassReg. "MSB of header"
	cogit CmpCq: objectMemory numSlotsMask R: ClassReg.
	jumpSmallSize := cogit JumpBelow: 0.
	cogit MoveMw: -8 r: ReceiverResultReg R: ClassReg. "LSW of overflow size header"

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
	jumpSmallSize jmpTarget:
					(cogit CmpCq: objectMemory weakArrayFormat R: formatReg).
	jumpNotPointers := cogit JumpAbove: 0.
	"optimistic store check; assume index in range (almost always is)."
	self genStoreCheckReceiverReg: ReceiverResultReg valueReg: Arg1Reg scratchReg: TempReg.

	cogit CmpCq: objectMemory arrayFormat R: formatReg.
	jumpNotIndexablePointers := cogit JumpBelow: 0.
	jumpHasFixedFields := cogit JumpNonZero: 0.
	cogit CmpR: Arg0Reg R: ClassReg.
	jumpArrayOutOfBounds := cogit JumpBelowOrEqual: 0.
	cogit AddCq: objectMemory baseHeaderSize >> objectMemory shiftForWord R: Arg0Reg.
	cogit MoveR: Arg1Reg Xwr: Arg0Reg R: ReceiverResultReg.
	cogit MoveR: Arg1Reg R: ReceiverResultReg.
	cogit RetN: retNoffset.

	jumpHasFixedFields jmpTarget: cogit Label.
	self genGetClassIndexOfNonImm: ReceiverResultReg into: formatReg.
	cogit CmpCq: ClassMethodContextCompactIndex R: formatReg.
	jumpIsContext := cogit JumpZero: 0.
	"get # fixed fields in formatReg"
	cogit PushR: ClassReg.
	self genGetClassObjectOfClassIndex: formatReg into: ClassReg scratchReg: TempReg.
	self genLoadSlot: InstanceSpecificationIndex sourceReg: ClassReg destReg: formatReg.
	cogit PopR: ClassReg.
	self genConvertSmallIntegerToIntegerInReg: formatReg.
	cogit AndCq: objectMemory fixedFieldsOfClassFormatMask R: formatReg.
	cogit SubR: formatReg R: ClassReg.
	cogit AddCq: objectMemory baseHeaderSize >> objectMemory shiftForWord R: formatReg.
	cogit CmpR: Arg0Reg R: ClassReg.
	jumpFixedFieldsOutOfBounds := cogit JumpBelowOrEqual: 0.
	cogit AddR: formatReg R: Arg0Reg.
	cogit MoveR: Arg1Reg Xwr: Arg0Reg R: ReceiverResultReg.
	cogit MoveR: Arg1Reg R: ReceiverResultReg.
	cogit RetN: retNoffset.

	jumpNotPointers jmpTarget:
		(cogit CmpCq: objectMemory firstCompiledMethodFormat R: formatReg).
	jumpIsCompiledMethod := cogit JumpAboveOrEqual: 0.
	cogit MoveR: Arg1Reg R: TempReg.
	jumpNonSmallIntegerValue := self genJumpNotSmallIntegerInScratchReg: TempReg.
					cogit CmpCq: objectMemory firstByteFormat R: formatReg.
	jumpIsBytes := cogit JumpAboveOrEqual: 0.
					cogit CmpCq: objectMemory firstShortFormat R: formatReg.
	jumpShortsUnsupported := cogit JumpAboveOrEqual: 0.
					cogit CmpCq: objectMemory firstLongFormat R: formatReg.
	"For now ignore 64-bit indexability."
	jumpNotIndexableBits := cogit JumpBelow: 0.

	cogit CmpR: Arg0Reg R: ClassReg.
	jumpWordsOutOfBounds := cogit JumpBelowOrEqual: 0.
	cogit MoveR: Arg1Reg R: TempReg.
	self genConvertSmallIntegerToIntegerInReg: TempReg.
	cogit AddCq: objectMemory baseHeaderSize >> objectMemory shiftForWord R: Arg0Reg.
	cogit MoveR: TempReg Xwr: Arg0Reg R: ReceiverResultReg.
	cogit MoveR: Arg1Reg R: ReceiverResultReg.
	cogit RetN: retNoffset.

	jumpIsBytes jmpTarget:
		(cogit CmpCq: (objectMemory integerObjectOf: 255) R: Arg1Reg).
	jumpBytesOutOfRange := cogit JumpAbove: 0.
	cogit LogicalShiftLeftCq: objectMemory shiftForWord R: ClassReg.
	cogit AndCq: objectMemory wordSize - 1 R: formatReg.
	cogit SubR: formatReg R: ClassReg;
	CmpR: Arg0Reg R: ClassReg.
	jumpBytesOutOfBounds := cogit JumpBelowOrEqual: 0.
	cogit MoveR: Arg1Reg R: TempReg.
	self genConvertSmallIntegerToIntegerInReg: TempReg.
	cogit AddCq: objectMemory baseHeaderSize R: Arg0Reg.
	cogit MoveR: TempReg Xbr: Arg0Reg R: ReceiverResultReg.
	cogit MoveR: Arg1Reg R: ReceiverResultReg.
	cogit RetN: retNoffset.

	"there are no shorts as yet.  so this is dead code:
	jumpIsShorts jmpTarget:
		(cogit CmpCq: (objectMemory integerObjectOf: 65535) R: Arg1Reg).
	jumpShortsOutOfRange := cogit JumpAbove: 0.
	cogit LogicalShiftLeftCq: objectMemory shiftForWord - 1 R: ClassReg.
	cogit AndCq: 1 R: formatReg.
	cogit SubR: formatReg R: ClassReg;
	CmpR: Arg0Reg R: ClassReg.
	jumpShortsOutOfBounds := cogit JumpBelowOrEqual: 0.
	cogit MoveR: Arg1Reg R: TempReg.
	cogit genConvertSmallIntegerToIntegerInReg: TempReg.
	cogit AddR: Arg0Reg R: ReceiverResultReg.
	cogit MoveR: TempReg M16: objectMemory baseHeaderSize r: ReceiverResultReg.
	cogit MoveR: Arg1Reg R: ReceiverResultReg.
	jumpShortsDone := cogit Jump: 0."

	jumpIsContext jmpTarget: 
	(jumpNotIndexableBits jmpTarget:
	(jumpBytesOutOfRange jmpTarget:
	(jumpIsCompiledMethod jmpTarget:
	(jumpArrayOutOfBounds jmpTarget:
	(jumpBytesOutOfBounds jmpTarget:
	(jumpShortsUnsupported jmpTarget:
	(jumpWordsOutOfBounds jmpTarget:
	(jumpNotIndexablePointers jmpTarget:
	(jumpNonSmallIntegerValue jmpTarget:
	(jumpFixedFieldsOutOfBounds jmpTarget: cogit Label)))))))))).

	cogit AddCq: 1 R: Arg0Reg. "0-rel => 1-rel"
	self genConvertIntegerToSmallIntegerInScratchReg: Arg0Reg.

	jumpBadIndex jmpTarget: (jumpImmediate jmpTarget: cogit Label).

	^0