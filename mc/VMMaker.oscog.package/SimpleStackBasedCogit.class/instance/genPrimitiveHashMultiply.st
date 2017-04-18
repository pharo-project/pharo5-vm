primitive generators
genPrimitiveHashMultiply
	| highReg jmpFailImm jmpFailNonImm jmpNotSmallInt lowReg reenter |
	jmpNotSmallInt := objectRepresentation genJumpNotSmallInteger: ReceiverResultReg.
	objectRepresentation genConvertSmallIntegerToIntegerInReg: ReceiverResultReg.
	reenter := self MoveR: ReceiverResultReg R: (highReg := Arg1Reg).
	self
		ArithmeticShiftRightCq: 14 R: highReg;				"highReg := receiver bitShift: -14"
		AndCq: 16383 R: ReceiverResultReg;
		MoveR: ReceiverResultReg R: (lowReg := Arg0Reg);	"lowReg := receiver bitAnd: 16383"
		MoveCq: 16r260D R: TempReg;
		MulR: TempReg R: ReceiverResultReg;				"RRR := 16r260D * low"
		MulR: TempReg R: highReg;						"highReg := (16r260D * (receiver bitShift: -14))"
		MoveCq: 16r0065 R: TempReg;
		MulR: TempReg R: lowReg;							"lowReg := 16r0065 * low"
		AddR: lowReg R: highReg;							"highReg := (16r260D * (receiver bitShift: -14)) + (16r0065 * low)"
		MoveCq: 16384 R: TempReg;
		MulR: TempReg R: highReg;						"highReg := (16r260D * (receiver bitShift: -14)) + (16r0065 * low)"
		AddR: highReg R: ReceiverResultReg;
		AndCq: 16r0FFFFFFF R: ReceiverResultReg.
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