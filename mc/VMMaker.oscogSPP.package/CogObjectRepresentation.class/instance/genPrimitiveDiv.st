primitive generators
genPrimitiveDiv
	| jumpNotSI jumpIsSI jumpZero jumpExact jumpSameSign convert |
	<var: #convert type: #'AbstractInstruction *'>
	<var: #jumpIsSI type: #'AbstractInstruction *'>
	<var: #jumpZero type: #'AbstractInstruction *'>
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	<var: #jumpExact type: #'AbstractInstruction *'>
	<var: #jumpSameSign type: #'AbstractInstruction *'>
	cogit processorHasDivQuoRemAndMClassIsSmallInteger ifFalse:
		[^UnimplementedPrimitive].
	cogit genLoadArgAtDepth: 0 into: Arg0Reg.
	cogit MoveR: Arg0Reg R: ClassReg.
	cogit MoveR: Arg0Reg R: Arg1Reg.
	jumpNotSI := self genJumpNotSmallInteger: Arg0Reg scratchReg: TempReg.
	"We must shift away the tags, not just subtract them, so that the
	 overflow case doesn't actually overflow the machine instruction."
	self genShiftAwaySmallIntegerTagsInScratchReg: ClassReg.
	(cogit lastOpcode setsConditionCodesFor: JumpZero) ifFalse:
		[cogit CmpCq: 0 R: ClassReg].
	jumpZero := cogit JumpZero: 0.
	cogit MoveR: ReceiverResultReg R: TempReg.
	self genShiftAwaySmallIntegerTagsInScratchReg: TempReg.
	cogit DivR: ClassReg R: TempReg Quo: TempReg Rem: ClassReg.
	"If remainder is zero we must check for overflow."
	cogit CmpCq: 0 R: ClassReg.
	jumpExact := cogit JumpZero: 0.
	"If arg and remainder signs are different we must round down."
	cogit XorR: ClassReg R: Arg1Reg.
	(cogit lastOpcode setsConditionCodesFor: JumpZero) ifFalse:
		[cogit CmpCq: 0 R: Arg1Reg].
	jumpSameSign := cogit JumpGreaterOrEqual: 0.
	cogit SubCq: 1 R: TempReg.
	jumpSameSign jmpTarget: (convert := cogit Label).
	self genConvertIntegerToSmallIntegerInReg: TempReg.
	cogit MoveR: TempReg R: ReceiverResultReg.
	cogit genPrimReturn.
	"test for overflow; the only case is SmallInteger minVal // -1"
	jumpExact jmpTarget: cogit Label.
	jumpIsSI := self genJumpIsSmallIntegerValue: TempReg scratch: Arg1Reg.
	jumpIsSI jmpTarget: convert.
	jumpZero jmpTarget: (jumpNotSI jmpTarget: cogit Label).
	^CompletePrimitive