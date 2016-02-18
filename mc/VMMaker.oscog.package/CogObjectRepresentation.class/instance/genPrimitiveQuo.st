primitive generators
genPrimitiveQuo
	| convert jumpNotSI jumpZero jumpIsSI jumpExact |
	<var: #convert type: #'AbstractInstruction *'>
	<var: #jumpIsSI type: #'AbstractInstruction *'>
	<var: #jumpZero type: #'AbstractInstruction *'>
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	<var: #jumpExact type: #'AbstractInstruction *'>
	cogit processorHasDivQuoRemAndMClassIsSmallInteger ifFalse:
		[^UnimplementedPrimitive].
	cogit genLoadArgAtDepth: 0 into: Arg0Reg.
	cogit MoveR: Arg0Reg R: ClassReg.
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
	convert := cogit Label.
	self genConvertIntegerToSmallIntegerInReg: TempReg.
	cogit MoveR: TempReg R: ReceiverResultReg.
	cogit genPrimReturn.
	jumpExact jmpTarget: cogit Label.
	jumpIsSI := self genJumpIsSmallIntegerValue: TempReg scratch: Arg1Reg.
	jumpIsSI jmpTarget: convert.
	jumpZero jmpTarget: (jumpNotSI jmpTarget: cogit Label).
	^CompletePrimitive