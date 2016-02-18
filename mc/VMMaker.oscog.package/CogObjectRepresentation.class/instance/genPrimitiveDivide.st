primitive generators
genPrimitiveDivide
	| jumpNotSI jumpZero jumpInexact jumpOverflow |
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	<var: #jumpZero type: #'AbstractInstruction *'>
	<var: #jumpInexact type: #'AbstractInstruction *'>
	<var: #jumpOverflow type: #'AbstractInstruction *'>
	cogit processorHasDivQuoRemAndMClassIsSmallInteger ifFalse:
		[^UnimplementedPrimitive].
	cogit genLoadArgAtDepth: 0 into: Arg0Reg.
	cogit MoveR: Arg0Reg R: ClassReg.
	jumpNotSI := self genJumpNotSmallInteger: Arg0Reg scratchReg: TempReg.
	"We must shift away the tags, not just subtract them, so that the
	 overflow case doesn't actually overflow the machine instruction."
	self genShiftAwaySmallIntegerTagsInScratchReg: ClassReg.
	jumpZero := cogit JumpZero: 0.
	cogit MoveR: ReceiverResultReg R: TempReg.
	self genShiftAwaySmallIntegerTagsInScratchReg: TempReg.
	cogit DivR: ClassReg R: TempReg Quo: TempReg Rem: ClassReg.
	"If remainder is non-zero fail."
	cogit CmpCq: 0 R: ClassReg.
	jumpInexact := cogit JumpNonZero: 0.
	"test for overflow; the only case is SmallInteger minVal / -1"
	jumpOverflow := self genJumpNotSmallIntegerValue: TempReg scratch: Arg1Reg.
	self genConvertIntegerToSmallIntegerInReg: TempReg.
	cogit MoveR: TempReg R: ReceiverResultReg.
	cogit genPrimReturn.
	jumpOverflow jmpTarget: (jumpInexact jmpTarget: (jumpZero jmpTarget: (jumpNotSI jmpTarget: cogit Label))).
	^CompletePrimitive