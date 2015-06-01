primitive generators
genInnerPrimitiveIdentityHash: retNOffset
	| jumpSI |
	<var: #jumpSI type: #'AbstractInstruction *'>
	jumpSI := self genJumpSmallInteger: ReceiverResultReg.
	self genGetHashFieldNonImmOf: ReceiverResultReg asSmallIntegerInto: TempReg.
	cogit MoveR: TempReg R: ReceiverResultReg.
	cogit RetN: retNOffset.
	jumpSI jmpTarget: cogit Label.
	^0