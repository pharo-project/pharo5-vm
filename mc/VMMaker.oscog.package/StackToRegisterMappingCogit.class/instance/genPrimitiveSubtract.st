primitive generators
genPrimitiveSubtract
	| jumpNotSI jumpOvfl |
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	<var: #jumpOvfl type: #'AbstractInstruction *'>
	jumpNotSI := objectRepresentation genJumpNotSmallInteger: Arg0Reg scratchReg: TempReg.
	self MoveR: ReceiverResultReg R: TempReg.
	self SubR: Arg0Reg R: TempReg.
	jumpOvfl := self JumpOverflow: 0.
	objectRepresentation genAddSmallIntegerTagsTo: TempReg.
	self MoveR: TempReg R: ReceiverResultReg.
	self RetN: 0.
	jumpOvfl jmpTarget: (jumpNotSI jmpTarget: self Label).
	^0