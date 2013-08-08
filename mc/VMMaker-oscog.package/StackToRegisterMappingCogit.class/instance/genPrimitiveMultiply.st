primitive generators
genPrimitiveMultiply
	| jumpNotSI jumpOvfl |
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	<var: #jumpOvfl type: #'AbstractInstruction *'>
	self MoveR: Arg0Reg R: TempReg.
	self MoveR: Arg0Reg R: ClassReg.
	self MoveR: ReceiverResultReg R: Arg1Reg.
	jumpNotSI := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	objectRepresentation genShiftAwaySmallIntegerTagsInScratchReg: ClassReg.
	objectRepresentation genRemoveSmallIntegerTagsInScratchReg: Arg1Reg.
	self MulR: Arg1Reg R: ClassReg.
	jumpOvfl := self JumpOverflow: 0.
	objectRepresentation genSetSmallIntegerTagsIn: ClassReg.
	self MoveR: ClassReg R: ReceiverResultReg.
	self RetN: 0.
	jumpOvfl jmpTarget: (jumpNotSI jmpTarget: self Label).
	^0