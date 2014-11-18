primitive generators
genPrimitiveBitAnd
	| jumpNotSI |
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	self MoveMw: objectMemory wordSize r: SPReg R: TempReg.
	self MoveR: TempReg R: ClassReg.
	jumpNotSI := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	"Whether the SmallInteger tags are zero or non-zero, anding them together will preserve them."
	self AndR: ClassReg R: ReceiverResultReg.
	self flag: 'currently caller pushes result'.
	self RetN: objectMemory wordSize * 2.
	jumpNotSI jmpTarget: self Label.
	^0