primitive generators
genPrimitiveSubtract
	| jumpNotSI jumpOvfl |
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	<var: #jumpOvfl type: #'AbstractInstruction *'>
	cogit mclassIsSmallInteger ifFalse:
		[^UnimplementedPrimitive].
	cogit genLoadArgAtDepth: 0 into: Arg0Reg.
	jumpNotSI := self genJumpNotSmallInteger: Arg0Reg scratchReg: TempReg.
	cogit MoveR: ReceiverResultReg R: TempReg.
	cogit SubR: Arg0Reg R: TempReg.
	jumpOvfl := cogit JumpOverflow: 0.
	self genAddSmallIntegerTagsTo: TempReg.
	cogit MoveR: TempReg R: ReceiverResultReg.
	cogit genPrimReturn.
	jumpOvfl jmpTarget: (jumpNotSI jmpTarget: cogit Label).
	^CompletePrimitive