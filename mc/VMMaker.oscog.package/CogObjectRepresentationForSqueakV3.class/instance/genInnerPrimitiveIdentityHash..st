primitive generators
genInnerPrimitiveIdentityHash: retNOffset
	| jumpSI |
	<var: #jumpSI type: #'AbstractInstruction *'>
	cogit MoveR: ReceiverResultReg R: ClassReg.
	jumpSI := self genJumpSmallIntegerInScratchReg: ClassReg.
	self genGetHashFieldNonImmOf: ReceiverResultReg asSmallIntegerInto: TempReg.
	cogit MoveR: TempReg R: ReceiverResultReg.
	cogit RetN: retNOffset.
	jumpSI jmpTarget: cogit Label.
	^0