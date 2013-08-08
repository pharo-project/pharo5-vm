primitive generators
genPrimitiveMod
	| jumpNotSI jumpZero jumpExact jumpSameSign |
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	<var: #jumpZero type: #'AbstractInstruction *'>
	<var: #jumpExact type: #'AbstractInstruction *'>
	<var: #jumpSameSign type: #'AbstractInstruction *'>
	self MoveR: Arg0Reg R: TempReg.
	self MoveR: Arg0Reg R: ClassReg.
	jumpNotSI := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	objectRepresentation genRemoveSmallIntegerTagsInScratchReg: ClassReg.
	jumpZero := self JumpZero: 0.
	self MoveR: ClassReg R: Arg1Reg.
	self MoveR: ReceiverResultReg R: TempReg.
	objectRepresentation genRemoveSmallIntegerTagsInScratchReg: TempReg.
	self DivR: ClassReg R: TempReg Quo: TempReg Rem: ClassReg.
	"If remainder is zero we're done."
	self CmpCq: 0 R: ClassReg.
	jumpExact := self JumpZero: 0.
	"If arg and remainder signs are different we must reflect around zero."
	self XorR: ClassReg R: Arg1Reg.
	(self lastOpcode setsConditionCodesFor: JumpZero) ifFalse:
		[self CmpCq: 0 R: Arg1Reg].
	jumpSameSign := self JumpGreaterOrEqual: 0.
	self XorR: ClassReg R: Arg1Reg.
	self AddR: Arg1Reg R: ClassReg.
	jumpSameSign jmpTarget: (jumpExact jmpTarget: self Label).
	objectRepresentation genSetSmallIntegerTagsIn: ClassReg.
	self MoveR: ClassReg R: ReceiverResultReg.
	self RetN: 0.
	jumpZero jmpTarget: (jumpNotSI jmpTarget: self Label).
	^0