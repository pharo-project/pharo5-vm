primitive generators
genPrimitiveMirrorNewWithArg
	"Implement instantiateVariableClass:withSize: for convenient cases:
	- the class argument has a hash
	- the class argument is variable and not compiled method
	- single word header/num slots < numSlotsMask
	- the result fits in eden
	See superclass method for dynamic frequencies of formats.
	For the moment we implement only arrayFormat, firstByteFormat & firstLongFormat"

	<option: #NewspeakVM>
	| halfHeaderReg fillReg instSpecReg byteSizeReg maxSlots
	  jumpArrayTooBig jumpByteTooBig jumpLongTooBig
	  jumpArrayFormat jumpByteFormat jumpBytePrepDone jumpLongPrepDone
	  jumpUnhashed jumpTooSmall jumpImmediate jumpNotFixedPointers
	  jumpNElementsNonInt jumpFailCuzFixed jumpNoSpace jumpHasSlots fillLoop skip |
	<var: 'skip' type: #'AbstractInstruction *'>
	<var: 'fillLoop' type: #'AbstractInstruction *'>	
	<var: 'jumpHasSlots' type: #'AbstractInstruction *'>
	<var: 'jumpNoSpace' type: #'AbstractInstruction *'>
	<var: 'jumpTooSmall' type: #'AbstractInstruction *'>
	<var: 'jumpUnhashed' type: #'AbstractInstruction *'>
	<var: 'jumpImmediate' type: #'AbstractInstruction *'>
	<var: 'jumpByteFormat' type: #'AbstractInstruction *'>
	<var: 'jumpByteTooBig' type: #'AbstractInstruction *'>
	<var: 'jumpLongTooBig' type: #'AbstractInstruction *'>
	<var: 'jumpArrayFormat' type: #'AbstractInstruction *'>
	<var: 'jumpArrayTooBig' type: #'AbstractInstruction *'>
	<var: 'jumpFailCuzFixed' type: #'AbstractInstruction *'>
	<var: 'jumpBytePrepDone' type: #'AbstractInstruction *'>
	<var: 'jumpLongPrepDone' type: #'AbstractInstruction *'>
	<var: 'jumpNElementsNonInt' type: #'AbstractInstruction *'>
	<var: 'jumpNotFixedPointers' type: #'AbstractInstruction *'>

	self assert: cogit methodNumArgs = 2.
	cogit genLoadArgAtDepth: 1 into: Arg0Reg. "class arg"
	cogit genLoadArgAtDepth: 0 into: Arg1Reg. "num indexable slots arg"

	"half header will contain 1st half of header (classIndex/class's hash & format),
	 then 2nd half of header (numSlots) and finally fill value (nilObject)."
	halfHeaderReg := fillReg := SendNumArgsReg.
	"inst spec will hold class's instance specification and then byte size and finally numSlots half of header"
	instSpecReg := byteSizeReg := ClassReg.
	"The max slots we'll allocate here are those for a single header"
	maxSlots := objectMemory numSlotsMask - 1.

	"check size and fail if not a +ve integer"
	jumpNElementsNonInt := self genJumpNotSmallInteger: Arg1Reg scratchReg: TempReg.

	"Is the class arg pointers with at least 3 fields?"
	jumpImmediate := self genJumpImmediate: Arg0Reg.
	self genGetRawSlotSizeOfNonImm: Arg0Reg into: TempReg.
	cogit CmpCq: InstanceSpecificationIndex + 1 R: TempReg.
	jumpTooSmall := cogit JumpLess: 0.

	"fail if not indexable class"
	self genGetFormatOf: Arg0Reg
		into: TempReg
		leastSignificantHalfOfBaseHeaderIntoScratch: NoReg.
	cogit CmpCq: objectMemory nonIndexablePointerFormat R: TempReg.
	jumpNotFixedPointers := cogit JumpNonZero: 0.
	
	"get class's hash & fail if 0"
	self genGetHashFieldNonImmOf: Arg0Reg into: halfHeaderReg.
	jumpUnhashed := cogit JumpZero: 0.

	"The basicNew: code below (copied from genPrimitiveNewWithArg) expects class
	 in ReceiverResultReg and size in Arg0Reg.  Shuffle args to match, undoing on failure."
	cogit
		PushR: ReceiverResultReg;
		MoveR: Arg0Reg R: ReceiverResultReg;
		MoveR: Arg1Reg R: Arg0Reg.

	"get freeStart as early as possible so as not to wait later..."
	cogit MoveAw: objectMemory freeStartAddress R: Arg1Reg.
	"get class's format inst var for inst spec (format field)"
	self genLoadSlot: InstanceSpecificationIndex sourceReg: ReceiverResultReg destReg: instSpecReg.
	cogit LogicalShiftRightCq: objectMemory fixedFieldsFieldWidth + self numSmallIntegerTagBits R: instSpecReg.
	cogit AndCq: objectMemory formatMask R: instSpecReg.
	"Add format to classIndex/format half header now"
	cogit MoveR: instSpecReg R: TempReg.
	cogit LogicalShiftLeftCq: objectMemory formatShift R: TempReg.
	cogit AddR: TempReg R: halfHeaderReg.
	"get integer value of num fields in TempReg now"
	cogit MoveR: Arg0Reg R: TempReg.
	self genConvertSmallIntegerToIntegerInReg: TempReg.
	"dispatch on format, failing if not variable or if compiled method"
	cogit CmpCq: objectMemory arrayFormat R: instSpecReg.
	jumpArrayFormat := cogit JumpZero: 0.
	cogit CmpCq: objectMemory firstByteFormat R: instSpecReg.
	jumpByteFormat := cogit JumpZero: 0.
	cogit CmpCq: objectMemory firstLongFormat R: instSpecReg.
	jumpFailCuzFixed := cogit JumpNonZero: 0.

	cogit CmpCq: (objectMemory integerObjectOf: maxSlots) R: Arg0Reg.
	jumpLongTooBig := cogit JumpAbove: 0.
	"save num elements/slot size to instSpecReg"
	cogit MoveR: TempReg R: instSpecReg.
	"push fill value"
	cogit PushCq: 0.
	jumpLongPrepDone := cogit Jump: 0. "go allocate"

	jumpByteFormat jmpTarget:
	(cogit CmpCq: (objectMemory integerObjectOf: maxSlots * objectMemory wordSize) R: Arg0Reg).
	jumpByteTooBig := cogit JumpAbove: 0.
	"save num elements to instSpecReg"
	cogit MoveR: TempReg R: instSpecReg.
	"compute odd bits and add into halfHeaderReg; oddBits := 4 - nElements bitAnd: 3"
	cogit MoveCq: objectMemory wordSize R: TempReg.
	cogit SubR: instSpecReg R: TempReg.
	cogit AndCq: objectMemory wordSize - 1 R: TempReg.
	cogit LogicalShiftLeftCq: objectMemory formatShift R: TempReg.
	cogit AddR: TempReg R: halfHeaderReg.
	"round up num elements to numSlots in instSpecReg"
	cogit AddCq: objectMemory wordSize - 1 R: instSpecReg.
	cogit LogicalShiftRightCq: objectMemory shiftForWord R: instSpecReg.
	"push fill value"
	cogit PushCq: 0.
	jumpBytePrepDone := cogit Jump: 0. "go allocate"

	jumpArrayFormat jmpTarget:
		(cogit CmpCq: (objectMemory integerObjectOf: maxSlots) R: Arg0Reg).
	jumpArrayTooBig := cogit JumpAbove: 0.
	"save num elements/slot size to instSpecReg"
	cogit MoveR: TempReg R: instSpecReg.
	"push fill value"
	cogit PushCw: objectMemory nilObject.
	"fall through to allocate"

	jumpBytePrepDone jmpTarget:
	(jumpLongPrepDone jmpTarget: cogit Label).

	"write half header now; it frees halfHeaderReg"
	cogit MoveR: halfHeaderReg Mw: 0 r: Arg1Reg.
	"save numSlots to halfHeaderReg"
	cogit MoveR: instSpecReg R: halfHeaderReg.
	"compute byte size; remember 0-sized objects still need 1 slot & allocation is
	 rounded up to 8 bytes."
	cogit CmpCq: 0 R: byteSizeReg. "a.k.a. instSpecReg"
	jumpHasSlots := cogit JumpNonZero: 0.
	cogit MoveCq: objectMemory baseHeaderSize * 2 R: byteSizeReg.
	skip := cogit Jump: 0.
	"round up to allocationUnit"
	jumpHasSlots jmpTarget:
	(cogit MoveR: byteSizeReg R: TempReg).
	cogit AndCq: 1 R: TempReg.
	cogit AddR: TempReg R: byteSizeReg.
	cogit AddCq: objectMemory baseHeaderSize / objectMemory wordSize R: byteSizeReg.
	cogit LogicalShiftLeftCq: objectMemory shiftForWord R: byteSizeReg.
	skip jmpTarget:
	"shift halfHeaderReg to put numSlots in correct place"
	(cogit LogicalShiftLeftCq: objectMemory numSlotsHalfShift R: halfHeaderReg).
	"check if allocation fits"
	cogit AddR: Arg1Reg R: byteSizeReg.
	cogit CmpCq: objectMemory getScavengeThreshold R: byteSizeReg.
	jumpNoSpace := cogit JumpAboveOrEqual: 0.
	"get result, increment freeStart and write it back. Arg1Reg holds new freeStart, the limit of the object"
	cogit MoveR: Arg1Reg R: ReceiverResultReg.
	cogit MoveR: byteSizeReg Aw: objectMemory freeStartAddress.
	"write other half of header (numSlots/0 identityHash)"
	cogit MoveR: halfHeaderReg Mw: 4 r: ReceiverResultReg.
	"now fill"
	cogit PopR: fillReg.
	cogit PopR: TempReg. "discard pushed receiver"
	cogit LoadEffectiveAddressMw: objectMemory baseHeaderSize r: ReceiverResultReg R: Arg1Reg.
	"at least two words; so can make this a [fill 2 words. reached limit?] whileFalse"
	fillLoop := 
	cogit MoveR: fillReg Mw: 0 r: Arg1Reg.
	cogit MoveR: fillReg Mw: 4 r: Arg1Reg.
	cogit AddCq: 8 R: Arg1Reg.
	cogit CmpR: Arg1Reg R: byteSizeReg.
	cogit JumpAbove: fillLoop.
	cogit genPrimReturn.

	"pop discarded fill value & fall through to failure"
	jumpNoSpace jmpTarget: (cogit PopR: TempReg).

	jumpFailCuzFixed jmpTarget:
	(jumpArrayTooBig jmpTarget:
	(jumpByteTooBig jmpTarget:
	(jumpLongTooBig jmpTarget: cogit Label))).

	"unshuffle arguments"
	cogit
		MoveR: Arg0Reg R: Arg1Reg;
		MoveR: ReceiverResultReg R: Arg0Reg;
		PopR: ReceiverResultReg.

	jumpUnhashed jmpTarget:
	(jumpImmediate jmpTarget:
	(jumpNotFixedPointers jmpTarget:
	(jumpTooSmall jmpTarget:
	(jumpNElementsNonInt jmpTarget: cogit Label)))).

	^0