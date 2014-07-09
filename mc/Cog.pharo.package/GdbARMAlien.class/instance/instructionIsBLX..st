testing
instructionIsBLX: instr
"is this a BLX <targetReg> instruction?"
	^instr >> 28 < 16rF "test for allowed condcode - 0xF is extension" and: [(instr bitAnd: 16r0FFFFFF0) = 16r12FFF30]