primitive generators
genPrimitiveIdentityHash
	| jumpSI |
	<var: #jumpSI type: #'AbstractInstruction *'>
	jumpSI := self genJumpSmallInteger: ReceiverResultReg.
	self genGetHashFieldNonImmOf: ReceiverResultReg asSmallIntegerInto: TempReg.
	cogit MoveR: TempReg R: ReceiverResultReg.
	cogit genPrimReturn.
	jumpSI jmpTarget: cogit Label.
	^0