primitive generators
genPrimitiveBitAnd
	| jumpNotSI |
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	self MoveR: Arg0Reg R: TempReg.
	jumpNotSI := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	"Whether the SmallInteger tags are zero or non-zero, oring them together will preserve them."
	self AndR: Arg0Reg R: ReceiverResultReg.
	self RetN: 0.
	jumpNotSI jmpTarget: self Label.
	^0