primitive generators
genPrimitiveAdd
	| jumpNotSI jumpOvfl |
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	<var: #jumpOvfl type: #'AbstractInstruction *'>
	cogit mclassIsSmallInteger ifFalse:
		[^UnimplementedPrimitive].
	cogit genLoadArgAtDepth: 0 into: Arg0Reg.
	cogit MoveR: Arg0Reg R: ClassReg.
	jumpNotSI := self genJumpNotSmallInteger: Arg0Reg scratchReg: TempReg.
	self genRemoveSmallIntegerTagsInScratchReg: ClassReg.
	cogit AddR: ReceiverResultReg R: ClassReg.
	jumpOvfl := cogit JumpOverflow: 0.
	cogit MoveR: ClassReg R: ReceiverResultReg.
	cogit genPrimReturn.
	jumpOvfl jmpTarget: (jumpNotSI jmpTarget: cogit Label).
	^CompletePrimitive