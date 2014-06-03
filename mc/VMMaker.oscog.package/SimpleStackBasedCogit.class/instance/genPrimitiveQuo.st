primitive generators
genPrimitiveQuo
	| jumpNotSI jumpZero jumpOverflow |
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	<var: #jumpZero type: #'AbstractInstruction *'>
	<var: #jumpOverflow type: #'AbstractInstruction *'>
	self MoveMw: BytesPerWord r: SPReg R: TempReg.
	self MoveR: TempReg R: ClassReg.
	jumpNotSI := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	"We must shift away the tags, not just subtract them, so that the
	 overflow case doesn't actually overflow the machine instruction."
	objectRepresentation genShiftAwaySmallIntegerTagsInScratchReg: ClassReg.
	(self lastOpcode setsConditionCodesFor: JumpZero) ifFalse:
		[self CmpCq: 0 R: ClassReg].
	jumpZero := self JumpZero: 0.
	self MoveR: ReceiverResultReg R: TempReg.
	objectRepresentation genShiftAwaySmallIntegerTagsInScratchReg: TempReg.
	self DivR: ClassReg R: TempReg Quo: TempReg Rem: ClassReg.
	"test for overflow; the only case is SmallInteger minVal quo: -1"
	self CmpCq: (1 << (objectRepresentation numSmallIntegerBits - 1)) R: TempReg.
	jumpOverflow := self JumpGreaterOrEqual: 0.
	objectRepresentation genConvertIntegerToSmallIntegerInReg: TempReg.
	self MoveR: TempReg R: ReceiverResultReg.
	self flag: 'currently caller pushes result'.
	self RetN: BytesPerWord * 2.
	jumpOverflow jmpTarget: (jumpZero jmpTarget: (jumpNotSI jmpTarget: self Label)).
	^0