primitive generators
genPrimitiveBitOr
	| jumpNotSI |
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	jumpNotSI := objectRepresentation genJumpNotSmallInteger: Arg0Reg scratchReg: TempReg.
	"Whether the SmallInteger tags are zero or non-zero, oring them together will preserve them."
	self OrR: Arg0Reg R: ReceiverResultReg.
	self RetN: 0.
	jumpNotSI jmpTarget: self Label.
	^0