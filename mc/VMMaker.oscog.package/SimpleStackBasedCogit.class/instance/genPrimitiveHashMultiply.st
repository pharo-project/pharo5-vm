primitive generators
genPrimitiveHashMultiply
	"Implement 28-bit hashMultiply for SmallInteger and LargePositiveInteger receivers."
	| jmpFailImm jmpFailNonImm jmpNotSmallInt reenter |
	jmpNotSmallInt := objectRepresentation genJumpNotSmallInteger: ReceiverResultReg.

	objectRepresentation genConvertSmallIntegerToIntegerInReg: ReceiverResultReg.
	reenter :=
	self MoveCq: HashMultiplyConstant R: TempReg.
	self MulR: TempReg R: ReceiverResultReg.
	self AndCq: HashMultiplyMask R: ReceiverResultReg.
	objectRepresentation genConvertIntegerToSmallIntegerInReg: ReceiverResultReg.
	self RetN: 0.

	jmpNotSmallInt jmpTarget: self Label.
	jmpFailImm := objectRepresentation genJumpImmediate: ReceiverResultReg.
	objectRepresentation genGetCompactClassIndexNonImmOf: ReceiverResultReg into: ClassReg.
	self CmpCq: ClassLargePositiveIntegerCompactIndex R: ClassReg.
	jmpFailNonImm := self JumpNonZero: 0.
	objectRepresentation genLoadSlot: 0 sourceReg: ReceiverResultReg destReg: ReceiverResultReg.
	self Jump: reenter.

	jmpFailImm jmpTarget: (jmpFailNonImm jmpTarget: self Label).
	^0