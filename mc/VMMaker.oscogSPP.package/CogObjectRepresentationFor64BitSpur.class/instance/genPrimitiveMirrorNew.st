primitive generators
genPrimitiveMirrorNew
	"Implement 1-arg (instantiateFixedClass:) primitiveNew for convenient cases:
	- the class argument has a hash
	- the class argument is fixed size (excluding ephemerons to save instructions & miniscule time)
	- single word header/num slots < numSlotsMask
	- the result fits in eden (actually below scavengeThreshold)"

	<option: #NewspeakVM>
	| headerReg fillReg instSpecReg byteSizeReg
	  jumpImmediate jumpUnhashed jumpNotFixedPointers jumpTooSmall jumpBadFormat
	  jumpNoSpace jumpTooBig jumpHasSlots jumpVariableOrEphemeron
	  fillLoop skip |
	<var: 'skip' type: #'AbstractInstruction *'>
	<var: 'fillLoop' type: #'AbstractInstruction *'>
	<var: 'jumpTooBig' type: #'AbstractInstruction *'>
	<var: 'jumpHasSlots' type: #'AbstractInstruction *'>
	<var: 'jumpNoSpace' type: #'AbstractInstruction *'>
	<var: 'jumpTooSmall' type: #'AbstractInstruction *'>
	<var: 'jumpUnhashed' type: #'AbstractInstruction *'>
	<var: 'jumpImmediate' type: #'AbstractInstruction *'>
	<var: 'jumpBadFormat' type: #'AbstractInstruction *'>
	<var: 'jumpNotFixedPointers' type: #'AbstractInstruction *'>
	<var: 'jumpVariableOrEphemeron' type: #'AbstractInstruction *'>

	self assert: cogit methodNumArgs = 1.
	cogit genLoadArgAtDepth: 0 into: Arg0Reg.

	"header will contain classIndex/class's hash & format & numSlots/fixed size and finally fill value (nilObject)."
	headerReg := fillReg := SendNumArgsReg.
	"inst spec will hold class's instance specification, then byte size and finally end of new object."
	instSpecReg := byteSizeReg := ClassReg.

	"get freeStart as early as possible so as not to wait later..."
	cogit MoveAw: objectMemory freeStartAddress R: Arg1Reg.

	"validate class arg; sigh, this mirror crap hobbles unfairly; there is a better way with selector namespaces..."
	jumpImmediate := self genJumpImmediate: Arg0Reg.

	"Is the class arg pointers with at least 3 fields?"
	self genGetFormatOf: Arg0Reg
		into: TempReg
		leastSignificantHalfOfBaseHeaderIntoScratch: NoReg.
	cogit CmpCq: objectMemory nonIndexablePointerFormat R: TempReg.
	jumpNotFixedPointers := cogit JumpNonZero: 0.
	
	self genGetRawSlotSizeOfNonImm: Arg0Reg into: TempReg.
	cogit CmpCq: InstanceSpecificationIndex + 1 R: TempReg.
	jumpTooSmall := cogit JumpLess: 0.

	"get class's hash & fail if 0"
	self genGetHashFieldNonImmOf: Arg0Reg into: headerReg.
	jumpUnhashed := cogit JumpZero: 0.

	"get class's format inst var for both inst spec (format field) and num fixed fields"
	self genLoadSlot: InstanceSpecificationIndex sourceReg: Arg0Reg destReg: instSpecReg.
	jumpBadFormat := self genJumpNotSmallInteger: instSpecReg scratchReg: TempReg.
	self genConvertSmallIntegerToIntegerInReg: instSpecReg.
	cogit MoveR: instSpecReg R: TempReg.
	cogit LogicalShiftRightCq: objectMemory fixedFieldsFieldWidth R: TempReg.
	cogit AndCq: objectMemory formatMask R: TempReg.
	cogit AndCq: objectMemory fixedFieldsOfClassFormatMask R: instSpecReg.
	"fail if not fixed or if ephemeron (rare beasts so save the cycles)"
	cogit CmpCq: objectMemory nonIndexablePointerFormat R: TempReg.
	jumpVariableOrEphemeron := cogit JumpAbove: 0.
	cogit CmpCq: objectMemory numSlotsMask R: instSpecReg.
	jumpTooBig := cogit JumpAboveOrEqual: 0.
	"Add format to classIndex/format in header; then add in numSlots"
	cogit LogicalShiftLeftCq: objectMemory formatShift R: TempReg.
	cogit AddR: TempReg R: headerReg.
	cogit MoveR: instSpecReg R: TempReg.
	cogit LogicalShiftLeftCq: objectMemory numSlotsFullShift R: TempReg.
	cogit AddR: TempReg R: headerReg.
	"compute byte size; remember 0-sized objects still need 1 slot."
	cogit CmpCq: 0 R: byteSizeReg. "a.k.a. instSpecReg"
	jumpHasSlots := cogit JumpNonZero: 0.
	cogit MoveCq: objectMemory baseHeaderSize * 2 R: byteSizeReg.
	skip := cogit Jump: 0.
	"round up to allocationUnit"
	jumpHasSlots jmpTarget:
	(cogit AddCq: objectMemory baseHeaderSize / objectMemory wordSize R: byteSizeReg).
	cogit LogicalShiftLeftCq: objectMemory shiftForWord R: byteSizeReg.
	skip jmpTarget:
	"check if allocation fits (freeSize + byteSize < scavengeThreshold); scavengeThreshold is constant."
	(cogit AddR: Arg1Reg R: byteSizeReg).
	cogit CmpCq: objectMemory getScavengeThreshold R: byteSizeReg.
	jumpNoSpace := cogit JumpAboveOrEqual: 0.
	"write back new freeStart; get result. byteSizeReg holds new freeStart, the limit of the object"
	cogit MoveR: byteSizeReg Aw: objectMemory freeStartAddress.
	cogit MoveR: Arg1Reg R: ReceiverResultReg.
	"write header"
	cogit MoveR: headerReg Mw: 0 r: Arg1Reg.
	"now fill"
	cogit LoadEffectiveAddressMw: objectMemory baseHeaderSize r: ReceiverResultReg R: Arg1Reg.
	cogit MoveCq: objectMemory nilObject R: fillReg.
	fillLoop := 
	cogit MoveR: fillReg Mw: 0 r: Arg1Reg.
	cogit AddCq: 8 R: Arg1Reg.
	cogit CmpR: Arg1Reg R: byteSizeReg.
	cogit JumpAbove: fillLoop.
	cogit genPrimReturn.

	jumpNotFixedPointers jmpTarget:
	(jumpBadFormat jmpTarget:
	(jumpTooSmall jmpTarget:
	(jumpImmediate jmpTarget:
	(jumpUnhashed jmpTarget:
	(jumpVariableOrEphemeron jmpTarget:
	(jumpTooBig jmpTarget:
	(jumpNoSpace jmpTarget: cogit Label))))))).

	^0