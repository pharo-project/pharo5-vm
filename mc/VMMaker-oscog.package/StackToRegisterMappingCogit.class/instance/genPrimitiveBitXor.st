primitive generators
genPrimitiveBitXor
	| jumpNotSI |
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	self MoveR: Arg0Reg R: TempReg.
	jumpNotSI := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	"Clear one or the other tag so that xoring will preserve them."
	objectRepresentation genRemoveSmallIntegerTagsInScratchReg: Arg0Reg.
	self XorR: Arg0Reg R: ReceiverResultReg.
	self RetN: 0.
	jumpNotSI jmpTarget: self Label.
	^0