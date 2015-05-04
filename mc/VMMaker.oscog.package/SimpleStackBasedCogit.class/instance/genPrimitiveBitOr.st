primitive generators
genPrimitiveBitOr
	| jumpNotSI |
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	self genLoadArgAtDepth: 0 into: TempReg.
	self MoveR: TempReg R: ClassReg.
	jumpNotSI := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	"Whether the SmallInteger tags are zero or non-zero, oring them together will preserve them."
	self OrR: ClassReg R: ReceiverResultReg.
	self RetN: (self primRetNOffsetFor: 1).
	jumpNotSI jmpTarget: self Label.
	^0