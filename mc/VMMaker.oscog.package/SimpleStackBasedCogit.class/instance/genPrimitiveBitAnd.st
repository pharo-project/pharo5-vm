primitive generators
genPrimitiveBitAnd
	| jumpNotSI |
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	self MoveMw: BytesPerWord r: SPReg R: TempReg.
	self MoveR: TempReg R: ClassReg.
	jumpNotSI := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	"Whether the SmallInteger tags are zero or non-zero, anding them together will preserve them."
	self AndR: ClassReg R: ReceiverResultReg.
	self flag: 'currently caller pushes result'.
	self RetN: BytesPerWord * 2.
	jumpNotSI jmpTarget: self Label.
	^0