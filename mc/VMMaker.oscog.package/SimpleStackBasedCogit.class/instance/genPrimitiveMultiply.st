primitive generators
genPrimitiveMultiply
	| jumpNotSI jumpOvfl |
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	<var: #jumpOvfl type: #'AbstractInstruction *'>
	self MoveMw: objectMemory wordSize r: SPReg R: TempReg.
	self MoveR: TempReg R: ClassReg.
	jumpNotSI := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	objectRepresentation genShiftAwaySmallIntegerTagsInScratchReg: ClassReg.
	self MoveR: ReceiverResultReg R: TempReg.
	objectRepresentation genRemoveSmallIntegerTagsInScratchReg: TempReg.
	self MulR: TempReg R: ClassReg.
	jumpOvfl := self JumpOverflow: 0.
	objectRepresentation genSetSmallIntegerTagsIn: ClassReg.
	self MoveR: ClassReg R: ReceiverResultReg.
	self flag: 'currently caller pushes result'.
	self RetN: objectMemory wordSize * 2.
	jumpOvfl jmpTarget: (jumpNotSI jmpTarget: self Label).
	^0