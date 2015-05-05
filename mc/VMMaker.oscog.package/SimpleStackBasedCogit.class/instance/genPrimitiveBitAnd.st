primitive generators
genPrimitiveBitAnd
	| jumpNotSI |
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	self genLoadArgAtDepth: 0 into: TempReg.
	self MoveR: TempReg R: ClassReg.
	jumpNotSI := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	"Whether the SmallInteger tags are zero or non-zero, anding them together will preserve them."
	self AndR: ClassReg R: ReceiverResultReg.
	self RetN: (self primRetNOffsetFor: 1).
	jumpNotSI jmpTarget: self Label.
	^0