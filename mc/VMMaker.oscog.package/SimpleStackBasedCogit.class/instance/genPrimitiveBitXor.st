primitive generators
genPrimitiveBitXor
	| jumpNotSI |
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	self MoveMw: objectMemory wordSize r: SPReg R: TempReg.
	self MoveR: TempReg R: ClassReg.
	jumpNotSI := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	"Clear one or the other tag so that xoring will preserve them."
	objectRepresentation genRemoveSmallIntegerTagsInScratchReg: ClassReg.
	self XorR: ClassReg R: ReceiverResultReg.
	self flag: 'currently caller pushes result'.
	self RetN: objectMemory wordSize * 2.
	jumpNotSI jmpTarget: self Label.
	^0