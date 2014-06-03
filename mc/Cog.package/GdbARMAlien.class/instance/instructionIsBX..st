testing
instructionIsBX: instr
"is this a BX <targetReg> instruction?"
	^instr >> 28 < 16rF "test for allowed condcode - 0xF is extension" and: [(instr bitAnd: 16r0FFFFFF0) = 16r12FFF10]