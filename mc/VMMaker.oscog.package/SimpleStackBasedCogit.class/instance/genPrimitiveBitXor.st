primitive generators
genPrimitiveBitXor
	| jumpNotSI |
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	self genLoadArgAtDepth: 0 into:TempReg.
	self MoveR: TempReg R: ClassReg.
	jumpNotSI := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	"Clear one or the other tag so that xoring will preserve them."
	objectRepresentation genRemoveSmallIntegerTagsInScratchReg: ClassReg.
	self XorR: ClassReg R: ReceiverResultReg.
	self RetN: (self primRetNOffsetFor: 1).
	jumpNotSI jmpTarget: self Label.
	^0