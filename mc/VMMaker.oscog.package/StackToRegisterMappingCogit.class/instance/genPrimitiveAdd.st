primitive generators
genPrimitiveAdd
	| jumpNotSI jumpOvfl |
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	<var: #jumpOvfl type: #'AbstractInstruction *'>
	self MoveR: Arg0Reg R: ClassReg.
	jumpNotSI := objectRepresentation genJumpNotSmallInteger: Arg0Reg scratchReg: TempReg.
	objectRepresentation genRemoveSmallIntegerTagsInScratchReg: ClassReg.
	self AddCheckOverflowR: ReceiverResultReg R: ClassReg.
	jumpOvfl := self JumpOverflow: 0.
	self MoveR: ClassReg R: ReceiverResultReg.
	self RetN: 0.
	jumpOvfl jmpTarget: (jumpNotSI jmpTarget: self Label).
	^0