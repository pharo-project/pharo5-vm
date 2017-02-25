primitive generators
genPrimitiveStringAtPut
	| formatReg jumpBadIndex jumpBadArg jumpImmutable
	  jumpIsBytes jumpIsShorts jumpNotString jumpIsCompiledMethod
	  jumpBytesOutOfRange jumpShortsOutOfRange jumpWordsOutOfRange
	  jumpBytesOutOfBounds jumpWordsOutOfBounds jumpShortsOutOfBounds |
	"c.f. StackInterpreter>>stSizeOf: SpurMemoryManager>>lengthOf:format: fixedFieldsOf:format:length:"
	<var: #jumpBadArg type: #'AbstractInstruction *'>
	<var: #jumpIsBytes type: #'AbstractInstruction *'>
	<var: #jumpIsShorts type: #'AbstractInstruction *'>
	<var: #jumpBadIndex type: #'AbstractInstruction *'>
	<var: #jumpBytesOutOfRange type: #'AbstractInstruction *'>
	<var: #jumpShortsOutOfRange type: #'AbstractInstruction *'>
	<var: #jumpWordsOutOfRange type: #'AbstractInstruction *'>
	<var: #jumpBytesOutOfBounds type: #'AbstractInstruction *'>
	<var: #jumpShortsOutOfBounds type: #'AbstractInstruction *'>
	<var: #jumpWordsOutOfBounds type: #'AbstractInstruction *'>

	cogit genLoadArgAtDepth: 1 into: Arg0Reg.
	cogit genLoadArgAtDepth: 0 into: Arg1Reg.

	jumpBadIndex := self genJumpNotSmallInteger: Arg0Reg.
	jumpBadArg := self genJumpNotCharacter: Arg1Reg.
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

	self genGetNumSlotsOf: ReceiverResultReg into: ClassReg.

	"dispatch on format; words and/or bytes.
		  0 to 8 = pointer objects, forwarders, reserved.
		  9 64-bit indexable
		10 - 11 32-bit indexable
		12 - 15 16-bit indexable
		16 - 23 byte indexable
		24 - 31 compiled method"
	cogit CmpCq: objectMemory firstLongFormat R: formatReg.
	jumpNotString := cogit JumpBelow: 0.
					cogit CmpCq: objectMemory firstCompiledMethodFormat R: formatReg.
	jumpIsCompiledMethod := cogit JumpAboveOrEqual: 0.
					cogit CmpCq: objectMemory firstByteFormat R: formatReg.
	jumpIsBytes := cogit JumpAboveOrEqual: 0.
					cogit CmpCq: objectMemory firstShortFormat R: formatReg.
	jumpIsShorts := cogit JumpAboveOrEqual: 0.

	"fall through to double words"
	cogit CmpCq: (objectMemory characterObjectOf: 1 << self numCharacterBits - 1) R: Arg1Reg.
	jumpWordsOutOfRange := cogit JumpAbove: 0.
	cogit LogicalShiftLeftCq: objectMemory shiftForWord - 2 R: ClassReg.
	cogit AndCq: objectMemory wordSize / 4 - 1 R: formatReg.
	cogit SubR: formatReg R: ClassReg.
	cogit CmpR: Arg0Reg R: ClassReg.
	jumpWordsOutOfBounds := cogit JumpBelowOrEqual: 0.
	cogit MoveR: Arg1Reg R: TempReg.
	self genConvertCharacterToCodeInReg: TempReg.
	cogit AddCq: objectMemory baseHeaderSize >> (objectMemory shiftForWord - 1) R: Arg0Reg.
	cogit MoveR: TempReg X32r: Arg0Reg R: ReceiverResultReg.
	cogit MoveR: Arg1Reg R: ReceiverResultReg.
	cogit genPrimReturn.

	jumpIsShorts jmpTarget:
		(cogit CmpCq: (objectMemory characterObjectOf: 65535) R: Arg1Reg).
	jumpShortsOutOfRange := cogit JumpAbove: 0.
	cogit LogicalShiftLeftCq: objectMemory shiftForWord - 1 R: ClassReg.
	cogit AndCq: objectMemory wordSize / 2 - 1 R: formatReg.
	cogit SubR: formatReg R: ClassReg.
	cogit CmpR: Arg0Reg R: ClassReg.
	jumpShortsOutOfBounds := cogit JumpBelowOrEqual: 0.
	cogit MoveR: Arg1Reg R: TempReg.
	self genConvertCharacterToCodeInReg: TempReg.
	cogit AddR: Arg0Reg R: ReceiverResultReg.
	cogit MoveR: TempReg M16: objectMemory baseHeaderSize r: ReceiverResultReg.
	cogit MoveR: Arg1Reg R: ReceiverResultReg.
	cogit genPrimReturn.

	jumpIsBytes jmpTarget:
		(cogit CmpCq: (objectMemory characterObjectOf: 255) R: Arg1Reg).
	jumpBytesOutOfRange := cogit JumpAbove: 0.
	cogit LogicalShiftLeftCq: objectMemory shiftForWord R: ClassReg.
	cogit AndCq: objectMemory wordSize - 1 R: formatReg.
	cogit SubR: formatReg R: ClassReg.
	cogit CmpR: Arg0Reg R: ClassReg.
	jumpBytesOutOfBounds := cogit JumpBelowOrEqual: 0.
	cogit MoveR: Arg1Reg R: TempReg.
	self genConvertCharacterToCodeInReg: TempReg.
	cogit AddCq: objectMemory baseHeaderSize R: Arg0Reg.
	cogit MoveR: TempReg Xbr: Arg0Reg R: ReceiverResultReg.
	cogit MoveR: Arg1Reg R: ReceiverResultReg.
	cogit genPrimReturn.

	jumpNotString jmpTarget:
	(jumpBytesOutOfRange jmpTarget:
	(jumpShortsOutOfRange jmpTarget:
	(jumpWordsOutOfRange jmpTarget:
	(jumpIsCompiledMethod jmpTarget:
	(jumpBytesOutOfBounds jmpTarget:
	(jumpShortsOutOfBounds jmpTarget:
	(jumpWordsOutOfBounds jmpTarget: cogit Label))))))).

	self cppIf: IMMUTABILITY
		ifTrue: [jumpImmutable jmpTarget: jumpNotString getJmpTarget].

	cogit AddCq: 1 R: Arg0Reg. "0-rel => 1-rel"
	self genConvertIntegerToSmallIntegerInReg: Arg0Reg.

	jumpBadArg jmpTarget:
	(jumpBadIndex jmpTarget: cogit Label).

	^CompletePrimitive