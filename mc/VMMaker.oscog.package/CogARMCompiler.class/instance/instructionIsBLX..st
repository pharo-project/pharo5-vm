testing
instructionIsBLX: instr
"is this a BLX <targetReg> instruction?"
	^(self conditionIsNotNever: instr)  and: [(instr bitAnd: 16r0FFFFFF0) = 16r12FFF30]