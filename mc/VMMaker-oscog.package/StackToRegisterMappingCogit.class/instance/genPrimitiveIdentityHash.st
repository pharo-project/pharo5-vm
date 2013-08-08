primitive generators
genPrimitiveIdentityHash
	| jumpSI |
	<var: #jumpSI type: #'AbstractInstruction *'>
	self MoveR: ReceiverResultReg R: ClassReg.
	jumpSI := objectRepresentation genJumpSmallIntegerInScratchReg: ClassReg.
	objectRepresentation genGetHashFieldNonIntOf: ReceiverResultReg asSmallIntegerInto: TempReg.
	self MoveR: TempReg R: ReceiverResultReg.
	self RetN: 0.
	jumpSI jmpTarget: self Label.
	^0