primitive generators
genPrimitiveMultiply
	| jumpNotSI jumpOvfl |
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	<var: #jumpOvfl type: #'AbstractInstruction *'>
	(cogit processorHasMultiplyAndMClassIsSmallInteger) ifFalse:
		[^UnimplementedPrimitive].
	cogit genLoadArgAtDepth: 0 into: Arg0Reg.
	cogit MoveR: Arg0Reg R: ClassReg.
	cogit MoveR: ReceiverResultReg R: Arg1Reg.
	jumpNotSI := self genJumpNotSmallInteger: Arg0Reg scratchReg: TempReg.
	self genShiftAwaySmallIntegerTagsInScratchReg: ClassReg.
	self genRemoveSmallIntegerTagsInScratchReg: Arg1Reg.
	cogit MulR: Arg1Reg R: ClassReg.
	jumpOvfl := cogit JumpOverflow: 0.
	self genSetSmallIntegerTagsIn: ClassReg.
	cogit MoveR: ClassReg R: ReceiverResultReg.
	cogit genPrimReturn.
	jumpOvfl jmpTarget: (jumpNotSI jmpTarget: cogit Label).
	^CompletePrimitive