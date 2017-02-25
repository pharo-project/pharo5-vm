primitive generators
genPrimitiveAtPut
	| formatReg nSlotsOrBytesReg methodInBounds
	  jumpImmediate jumpBadIndex jumpImmutable jumpNotIndexablePointers jumpNotIndexableBits
	  jumpIsContext jumpIsCompiledMethod jumpIsBytes jumpIsShorts jumpHasFixedFields
	  jumpArrayOutOfBounds jumpFixedFieldsOutOfBounds
	  jumpWordsOutOfBounds jumpShortsOutOfBounds jumpBytesOutOfBounds
	  jumpShortsOutOfRange jumpWordsOutOfRange jumpBytesOutOfRange
	  jumpNonSmallIntegerValue jumpNotPointers
	  |
	"c.f. StackInterpreter>>stSizeOf: SpurMemoryManager>>lengthOf:format: fixedFieldsOf:format:length:"
	<var: #jumpIsBytes type: #'AbstractInstruction *'>
	<var: #jumpIsShorts type: #'AbstractInstruction *'>
	<var: #jumpBadIndex type: #'AbstractInstruction *'>
	<var: #jumpIsContext type: #'AbstractInstruction *'>
	<var: #jumpImmediate type: #'AbstractInstruction *'>
	<var: #methodInBounds type: #'AbstractInstruction *'>
	<var: #jumpHasFixedFields type: #'AbstractInstruction *'>
	<var: #jumpNotIndexableBits type: #'AbstractInstruction *'>
	<var: #jumpBytesOutOfRange type: #'AbstractInstruction *'>
	<var: #jumpWordsOutOfRange type: #'AbstractInstruction *'>
	<var: #jumpShortsOutOfRange type: #'AbstractInstruction *'>
	<var: #jumpArrayOutOfBounds type: #'AbstractInstruction *'>
	<var: #jumpBytesOutOfBounds type: #'AbstractInstruction *'>
	<var: #jumpWordsOutOfBounds type: #'AbstractInstruction *'>
	<var: #jumpShortsOutOfBounds type: #'AbstractInstruction *'>
	<var: #jumpNotIndexablePointers type: #'AbstractInstruction *'>

	nSlotsOrBytesReg := ClassReg.

	cogit genLoadArgAtDepth: 1 into: Arg0Reg.
	cogit genLoadArgAtDepth: 0 into: Arg1Reg.
	jumpImmediate := self genJumpImmediate: ReceiverResultReg.
	jumpBadIndex := self genJumpNotSmallInteger: Arg0Reg scratchReg: TempReg.
	self genConvertSmallIntegerToIntegerInReg: Arg0Reg.
	cogit SubCq: 1 R: Arg0Reg. "1-rel => 0-rel"

	"formatReg := self formatOf: ReceiverResultReg"
	self cppIf: IMMUTABILITY
		ifTrue:
		[ self genGetFormatOf: ReceiverResultReg
			into: (formatReg := SendNumArgsReg)
			leastSignificantHalfOfBaseHeaderIntoScratch: TempReg.
		jumpImmutable := self genJumpBaseHeaderImmutable: TempReg ]
		ifFalse: 
		[ self genGetFormatOf: ReceiverResultReg
			into: (formatReg := SendNumArgsReg)
			leastSignificantHalfOfBaseHeaderIntoScratch: NoReg ].

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
		  9 64-bit indexable
		10 - 11 32-bit indexable
		12 - 15 16-bit indexable
		16 - 23 byte indexable
		24 - 31 compiled method"
	cogit CmpCq: objectMemory weakArrayFormat R: formatReg.
	jumpNotPointers := cogit JumpAbove: 0.
	"optimistic store check; assume index in range (almost always is)."
	self genStoreCheckReceiverReg: ReceiverResultReg
		valueReg: Arg1Reg
		scratchReg: TempReg
		inFrame: false.

	cogit CmpCq: objectMemory arrayFormat R: formatReg.
	jumpNotIndexablePointers := cogit JumpBelow: 0.
	jumpHasFixedFields := cogit JumpNonZero: 0.
	cogit CmpR: Arg0Reg R: nSlotsOrBytesReg.
	jumpArrayOutOfBounds := cogit JumpBelowOrEqual: 0.
	cogit AddCq: objectMemory baseHeaderSize >> objectMemory shiftForWord R: Arg0Reg.
	cogit MoveR: Arg1Reg Xwr: Arg0Reg R: ReceiverResultReg.
	cogit MoveR: Arg1Reg R: ReceiverResultReg.
	cogit genPrimReturn.

	jumpHasFixedFields jmpTarget: cogit Label.
	self genGetClassIndexOfNonImm: ReceiverResultReg into: formatReg.
	cogit CmpCq: ClassMethodContextCompactIndex R: formatReg.
	jumpIsContext := cogit JumpZero: 0.
	"get # fixed fields in formatReg"
	self genGetClassObjectOfClassIndex: formatReg into: Extra0Reg scratchReg: TempReg.
	self genLoadSlot: InstanceSpecificationIndex sourceReg: Extra0Reg destReg: formatReg.
	self genConvertSmallIntegerToIntegerInReg: formatReg.
	cogit AndCq: objectMemory fixedFieldsOfClassFormatMask R: formatReg.
	cogit SubR: formatReg R: nSlotsOrBytesReg.
	cogit AddCq: objectMemory baseHeaderSize >> objectMemory shiftForWord R: formatReg.
	cogit CmpR: Arg0Reg R: nSlotsOrBytesReg.
	jumpFixedFieldsOutOfBounds := cogit JumpBelowOrEqual: 0.
	cogit AddR: formatReg R: Arg0Reg.
	cogit MoveR: Arg1Reg Xwr: Arg0Reg R: ReceiverResultReg.
	cogit MoveR: Arg1Reg R: ReceiverResultReg.
	cogit genPrimReturn.

	jumpNotPointers jmpTarget: cogit Label.
	jumpNonSmallIntegerValue := self genJumpNotSmallInteger: Arg1Reg scratchReg: TempReg.
					cogit CmpCq: objectMemory firstByteFormat R: formatReg.
	jumpIsBytes := cogit JumpAboveOrEqual: 0.
					cogit CmpCq: objectMemory firstShortFormat R: formatReg.
	jumpIsShorts := cogit JumpAboveOrEqual: 0.
					cogit CmpCq: objectMemory firstLongFormat R: formatReg.
	"For now ignore 64-bit indexability."
	jumpNotIndexableBits := cogit JumpBelow: 0.

	"fall through to words"
	cogit CmpCq: (objectMemory integerObjectOf: 16rFFFFFFFF) R: Arg1Reg.
	jumpWordsOutOfRange := cogit JumpAbove: 0.
	cogit LogicalShiftLeftCq: objectMemory shiftForWord - 2 R: nSlotsOrBytesReg.
	cogit AndCq: objectMemory wordSize / 4 - 1 R: formatReg.
	cogit SubR: formatReg R: nSlotsOrBytesReg.
	cogit CmpR: Arg0Reg R: nSlotsOrBytesReg.
	jumpWordsOutOfBounds := cogit JumpBelowOrEqual: 0.
	cogit MoveR: Arg1Reg R: TempReg.
	self genConvertSmallIntegerToIntegerInReg: TempReg.
	cogit AddCq: objectMemory baseHeaderSize >> (objectMemory shiftForWord - 1) R: Arg0Reg.
	cogit MoveR: TempReg X32r: Arg0Reg R: ReceiverResultReg.
	cogit MoveR: Arg1Reg R: ReceiverResultReg.
	cogit genPrimReturn.

	jumpIsBytes jmpTarget:
		(cogit CmpCq: (objectMemory integerObjectOf: 255) R: Arg1Reg).
	jumpBytesOutOfRange := cogit JumpAbove: 0.
	cogit LogicalShiftLeftCq: objectMemory shiftForWord R: nSlotsOrBytesReg.
	cogit AndCq: objectMemory wordSize - 1 R: formatReg R: TempReg.
	cogit SubR: TempReg R: nSlotsOrBytesReg.
	cogit CmpR: Arg0Reg R: nSlotsOrBytesReg.
	jumpBytesOutOfBounds := cogit JumpBelowOrEqual: 0.
	cogit CmpCq: objectMemory firstCompiledMethodFormat R: formatReg.
	jumpIsCompiledMethod := cogit JumpAboveOrEqual: 0.
	methodInBounds :=
	cogit MoveR: Arg1Reg R: TempReg.
	self genConvertSmallIntegerToIntegerInReg: TempReg.
	cogit AddCq: objectMemory baseHeaderSize R: Arg0Reg.
	cogit MoveR: TempReg Xbr: Arg0Reg R: ReceiverResultReg.
	cogit MoveR: Arg1Reg R: ReceiverResultReg.
	cogit genPrimReturn.

	jumpIsShorts jmpTarget:
		(cogit CmpCq: (objectMemory integerObjectOf: 65535) R: Arg1Reg).
	jumpShortsOutOfRange := cogit JumpAbove: 0.
	cogit LogicalShiftLeftCq: objectMemory shiftForWord - 1 R: nSlotsOrBytesReg.
	cogit AndCq: objectMemory wordSize / 2 - 1 R: formatReg.
	cogit SubR: formatReg R: nSlotsOrBytesReg.
	cogit CmpR: Arg0Reg R: nSlotsOrBytesReg.
	jumpShortsOutOfBounds := cogit JumpBelowOrEqual: 0.
	cogit MoveR: Arg1Reg R: TempReg.
	self genConvertSmallIntegerToIntegerInReg: TempReg.
	cogit AddR: Arg0Reg R: ReceiverResultReg.
	cogit AddR: Arg0Reg R: ReceiverResultReg.
	cogit MoveR: TempReg M16: objectMemory baseHeaderSize r: ReceiverResultReg.
	cogit MoveR: Arg1Reg R: ReceiverResultReg.
	cogit genPrimReturn.

	"Now check that the index is beyond the method's literals..."
	jumpIsCompiledMethod jmpTarget: cogit Label.
	self getLiteralCountOf: ReceiverResultReg plusOne: true inBytes: true into: nSlotsOrBytesReg scratch: TempReg.
	cogit CmpR: Arg0Reg R: nSlotsOrBytesReg.
	cogit JumpBelow: methodInBounds.

	jumpIsContext jmpTarget:
	(jumpNotIndexableBits jmpTarget:
	(jumpBytesOutOfRange jmpTarget:
	(jumpShortsOutOfRange jmpTarget:
	(jumpWordsOutOfRange jmpTarget:
	(jumpIsCompiledMethod jmpTarget:
	(jumpArrayOutOfBounds jmpTarget:
	(jumpBytesOutOfBounds jmpTarget:
	(jumpShortsOutOfBounds jmpTarget:
	(jumpWordsOutOfBounds jmpTarget:
	(jumpNotIndexablePointers jmpTarget:
	(jumpNonSmallIntegerValue jmpTarget:
	(jumpFixedFieldsOutOfBounds jmpTarget: cogit Label)))))))))))).
	
	self cppIf: IMMUTABILITY
		ifTrue: [jumpImmutable jmpTarget: jumpIsContext getJmpTarget].

	cogit AddCq: 1 R: Arg0Reg. "0-rel => 1-rel"
	self genConvertIntegerToSmallIntegerInReg: Arg0Reg.

	jumpBadIndex jmpTarget: (jumpImmediate jmpTarget: cogit Label).

	^0 "Can't be complete because of contexts."