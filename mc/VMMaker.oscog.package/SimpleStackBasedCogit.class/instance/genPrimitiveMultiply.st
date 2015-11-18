primitive generators
genPrimitiveMultiply
	| jumpNotSI jumpOvfl |
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	<var: #jumpOvfl type: #'AbstractInstruction *'>
	self genLoadArgAtDepth: 0 into: TempReg.
	self MoveR: TempReg R: ClassReg.
	jumpNotSI := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	objectRepresentation genShiftAwaySmallIntegerTagsInScratchReg: ClassReg.
	self MoveR: ReceiverResultReg R: TempReg.
	objectRepresentation genRemoveSmallIntegerTagsInScratchReg: TempReg.
	self MulR: TempReg R: ClassReg.
	jumpOvfl := self JumpOverflow: 0.
	objectRepresentation genSetSmallIntegerTagsIn: ClassReg.
	self MoveR: ClassReg R: ReceiverResultReg.
	self RetN: (self primRetNOffsetFor: 1).
	jumpOvfl jmpTarget: (jumpNotSI jmpTarget: self Label).
	^0