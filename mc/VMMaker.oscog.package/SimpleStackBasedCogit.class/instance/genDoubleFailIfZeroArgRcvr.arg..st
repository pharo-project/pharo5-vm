primitive generators
genDoubleFailIfZeroArgRcvr: rcvrReg arg: argReg
	<option: #DPFPReg0>
	<returnTypeC: #'AbstractInstruction *'>
	self MoveCq: 0 R: TempReg.
	self ConvertR: TempReg Rd: DPFPReg2.
	self CmpRd: DPFPReg2 Rd: argReg.
	^self JumpFPEqual: 0