primitive generators
genPrimitiveMod
	| jumpNotSI jumpZero jumpExact jumpSameSign |
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	<var: #jumpZero type: #'AbstractInstruction *'>
	<var: #jumpExact type: #'AbstractInstruction *'>
	<var: #jumpSameSign type: #'AbstractInstruction *'>
	cogit processorHasDivQuoRemAndMClassIsSmallInteger ifFalse:
		[^UnimplementedPrimitive].
	cogit genLoadArgAtDepth: 0 into: Arg0Reg.
	cogit MoveR: Arg0Reg R: ClassReg.
	jumpNotSI := self genJumpNotSmallInteger: Arg0Reg scratchReg: TempReg.
	self genRemoveSmallIntegerTagsInScratchReg: ClassReg.
	jumpZero := cogit JumpZero: 0.
	cogit MoveR: ClassReg R: Arg1Reg.
	cogit MoveR: ReceiverResultReg R: TempReg.
	self genRemoveSmallIntegerTagsInScratchReg: TempReg.
	cogit DivR: ClassReg R: TempReg Quo: TempReg Rem: ClassReg.
	"If remainder is zero we're done."
	cogit CmpCq: 0 R: ClassReg.
	jumpExact := cogit JumpZero: 0.
	"If arg and remainder signs are different we must reflect around zero."
	cogit XorR: ClassReg R: Arg1Reg.
	(cogit lastOpcode setsConditionCodesFor: JumpZero) ifFalse:
		[cogit CmpCq: 0 R: Arg1Reg].
	jumpSameSign := cogit JumpGreaterOrEqual: 0.
	cogit XorR: ClassReg R: Arg1Reg.
	cogit AddR: Arg1Reg R: ClassReg.
	jumpSameSign jmpTarget: (jumpExact jmpTarget: cogit Label).
	self genSetSmallIntegerTagsIn: ClassReg.
	cogit MoveR: ClassReg R: ReceiverResultReg.
	cogit genPrimReturn.
	jumpZero jmpTarget: (jumpNotSI jmpTarget: cogit Label).
	^CompletePrimitive