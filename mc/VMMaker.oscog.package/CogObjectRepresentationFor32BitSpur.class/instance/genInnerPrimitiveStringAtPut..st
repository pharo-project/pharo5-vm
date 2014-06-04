primitive generators
genInnerPrimitiveStringAtPut: retNoffset
	"Implement the guts of primitiveStringAtPut"
	| formatReg jumpSmallSize jumpImmediate jumpBadIndex jumpBadArg
	  jumpWordsDone jumpBytesOutOfRange
	  jumpIsBytes jumpNotString jumpIsCompiledMethod
	  jumpBytesOutOfBounds jumpWordsOutOfBounds jumpShortsUnsupported |
	<inline: true>
	"c.f. StackInterpreter>>stSizeOf: SpurMemoryManager>>lengthOf:format: fixedFieldsOf:format:length:"
	<var: #jumpBadArg type: #'AbstractInstruction *'>
	<var: #jumpIsBytes type: #'AbstractInstruction *'>
	<var: #jumpBadIndex type: #'AbstractInstruction *'>
	<var: #jumpSmallSize type: #'AbstractInstruction *'>
	<var: #jumpImmediate type: #'AbstractInstruction *'>
	<var: #jumpWordsDone type: #'AbstractInstruction *'>
	<var: #jumpBytesOutOfBounds type: #'AbstractInstruction *'>
	<var: #jumpShortsUnsupported type: #'AbstractInstruction *'>
	<var: #jumpWordsOutOfBounds type: #'AbstractInstruction *'>

	cogit MoveR: ReceiverResultReg R: TempReg.
	jumpImmediate := self genJumpImmediateInScratchReg: TempReg.
	cogit MoveR: Arg0Reg R: TempReg.
	jumpBadIndex := self genJumpNotSmallIntegerInScratchReg: TempReg.
	cogit MoveR: Arg1Reg R: TempReg.
	jumpBadArg := self genJumpNotCharacterInScratchReg: TempReg.
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

	"dispatch on format; words and/or bytes.
		  0 to 8 = pointer objects, forwarders, reserved.
		  9 (?) 64-bit indexable
		10 - 11 32-bit indexable
		12 - 15 16-bit indexable (but unused)
		16 - 23 byte indexable
		24 - 31 compiled method"
	jumpSmallSize jmpTarget:
					(cogit CmpCq: objectMemory firstLongFormat R: formatReg).
	jumpNotString := cogit JumpBelowOrEqual: 0.
					cogit CmpCq: objectMemory firstCompiledMethodFormat R: formatReg.
	jumpIsCompiledMethod := cogit JumpAboveOrEqual: 0.
					cogit CmpCq: objectMemory firstByteFormat R: formatReg.
	jumpIsBytes := cogit JumpGreaterOrEqual: 0.
					cogit CmpCq: objectMemory firstShortFormat R: formatReg.
	jumpShortsUnsupported := cogit JumpGreaterOrEqual: 0.

	cogit CmpR: Arg0Reg R: ClassReg.
	jumpWordsOutOfBounds := cogit JumpBelowOrEqual: 0.
	cogit MoveR: Arg1Reg R: TempReg.
	self genConvertSmallIntegerToIntegerInReg: TempReg.
	cogit AddCq: objectMemory baseHeaderSize >> objectMemory shiftForWord R: Arg0Reg.
	cogit MoveR: TempReg Xwr: Arg0Reg R: ReceiverResultReg.
	cogit MoveR: Arg1Reg R: ReceiverResultReg.
	jumpWordsDone := cogit Jump: 0.

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

	jumpIsBytes jmpTarget:
		(cogit CmpCq: (objectMemory characterObjectOf: 255) R: Arg1Reg).
	jumpBytesOutOfRange := cogit JumpAbove: 0.
	cogit LogicalShiftLeftCq: objectMemory shiftForWord R: ClassReg.
	cogit AndCq: objectMemory wordSize - 1 R: formatReg.
	cogit SubR: formatReg R: ClassReg;
	CmpR: Arg0Reg R: ClassReg.
	jumpBytesOutOfBounds := cogit JumpBelowOrEqual: 0.
	cogit MoveR: Arg1Reg R: TempReg.
	self genConvertCharacterToCodeInReg: TempReg.
	cogit AddCq: objectMemory baseHeaderSize R: Arg0Reg.
	cogit MoveR: TempReg Xbr: Arg0Reg R: ReceiverResultReg.
	cogit MoveR: Arg1Reg R: ReceiverResultReg.

	jumpWordsDone jmpTarget:
		(cogit RetN: retNoffset).

	jumpBadArg jmpTarget:
	(jumpNotString jmpTarget:
	(jumpBytesOutOfRange jmpTarget:
	(jumpIsCompiledMethod jmpTarget:
	(jumpBytesOutOfBounds jmpTarget:
	(jumpShortsUnsupported jmpTarget:
	(jumpWordsOutOfBounds jmpTarget: cogit Label)))))).

	cogit AddCq: 1 R: Arg0Reg. "0-rel => 1-rel"
	self genConvertIntegerToSmallIntegerInScratchReg: Arg0Reg.

	jumpBadIndex jmpTarget: (jumpImmediate jmpTarget: cogit Label).

	^0