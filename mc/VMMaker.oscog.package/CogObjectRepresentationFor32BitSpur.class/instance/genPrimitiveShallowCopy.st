primitive generators
genPrimitiveShallowCopy
	"Implement primitiveShallowCopy/primitiveClone for convenient cases:
	- the receiver is not a context
	- the receiver is not a compiled method
	- the result fits in eden (actually below scavengeThreshold)"

	| formatReg resultReg slotsReg ptrReg
	  jumpImmediate jumpIsMethod jumpVariable jumpTooBig jumpEmpty jumpNoSpace
	  continuance copyLoop |
	<var: #copyLoop type: #'AbstractInstruction *'>
	<var: #jumpTooBig type: #'AbstractInstruction *'>
	<var: #continuance type: #'AbstractInstruction *'>
	<var: #jumpVariable type: #'AbstractInstruction *'>
	<var: #jumpNoSpace type: #'AbstractInstruction *'>
	<var: #jumpIsMethod type: #'AbstractInstruction *'>
	<var: #jumpImmediate type: #'AbstractInstruction *'>

	jumpImmediate := self genJumpImmediate: ReceiverResultReg.
	resultReg := Arg0Reg.
	slotsReg := Arg1Reg.
	"get freeStart as early as possible so as not to wait later..."
	cogit MoveAw: objectMemory freeStartAddress R: resultReg.

	"formatReg := self formatOf: ReceiverResultReg"
	self genGetFormatOf: ReceiverResultReg
		into: (ptrReg := formatReg := SendNumArgsReg)
		leastSignificantHalfOfBaseHeaderIntoScratch: NoReg.

	cogit CmpCq: objectMemory firstCompiledMethodFormat R: formatReg.
	jumpIsMethod := cogit JumpAboveOrEqual: 0.
	cogit CmpCq: objectMemory indexablePointersFormat R: formatReg.
	jumpVariable := cogit JumpZero: 0.
	continuance := cogit Label.

	self genGetRawSlotSizeOfNonImm: ReceiverResultReg into: slotsReg.
	cogit CmpCq: objectMemory numSlotsMask R: slotsReg.
	jumpTooBig := cogit JumpZero: 0.

	cogit CmpCq: 0 R: slotsReg.
	jumpEmpty := cogit JumpZero: 0.

	"round up to allocationUnit"
	cogit
		MoveR: slotsReg R: TempReg;
		AndCq: 1 R: TempReg;
		AddR: TempReg R: slotsReg;
		AddCq: objectMemory baseHeaderSize / objectMemory wordSize R: slotsReg;
		LogicalShiftLeftCq: objectMemory shiftForWord R: slotsReg;
	"check if allocation fits (freeSize + byteSize < scavengeThreshold); scavengeThreshold is constant."
		AddR: resultReg R: slotsReg;
		CmpCq: objectMemory getScavengeThreshold R: slotsReg.
	jumpNoSpace := cogit JumpAboveOrEqual: 0.
	cogit
		MoveR: resultReg R: ptrReg;
	"write back new freeStart; get result. slotsReg holds new freeStart, the limit of the object"
		MoveR: slotsReg Aw: objectMemory freeStartAddress;
	"set up loop bounds"
		SubCq: objectMemory wordSize * 2 R: slotsReg;
	"copy header, masking off irrelevant bits"
		MoveMw: 0 r: ReceiverResultReg R: TempReg;
		AndCq: objectMemory formatMask << objectMemory formatShift + objectMemory classIndexMask R: TempReg;
		MoveR: TempReg Mw: 0 r: resultReg;
		MoveMw: objectMemory wordSize r: ReceiverResultReg R: TempReg;
		AndCq: objectMemory numSlotsMask << objectMemory numSlotsHalfShift R: TempReg;
		MoveR: TempReg Mw: objectMemory wordSize r: resultReg.
	"copy two fields at a time..."
	copyLoop := cogit Label.
	cogit
		AddCq: objectMemory wordSize * 2 R: ReceiverResultReg;
		AddCq: objectMemory wordSize * 2 R: ptrReg;
		MoveMw: 0 r: ReceiverResultReg R: TempReg;
		MoveR: TempReg Mw: 0 r: ptrReg;
		MoveMw: objectMemory wordSize r: ReceiverResultReg R: TempReg;
		MoveR: TempReg Mw: objectMemory wordSize r: ptrReg;
		CmpR: ptrReg R: slotsReg;
		JumpAbove: copyLoop;
		MoveR: resultReg R: ReceiverResultReg;
		genPrimReturn.

	"If the receiver is variable pointers, fail if its a context, otherwise continue"
	jumpVariable jmpTarget: cogit Label.
	self genGetClassIndexOfNonImm: ReceiverResultReg into: ClassReg.
	cogit
		CmpCq: ClassMethodContextCompactIndex R: ClassReg;
		JumpNonZero: continuance.

	jumpImmediate jmpTarget:
	(jumpNoSpace jmpTarget:
	(jumpIsMethod jmpTarget:
	(jumpTooBig jmpTarget:
	(jumpEmpty jmpTarget: cogit Label)))).

	^0