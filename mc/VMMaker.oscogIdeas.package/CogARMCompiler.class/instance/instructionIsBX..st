testing
instructionIsBX: instr
"is this a BX <targetReg> instruction?"
	^(self conditionIsNotNever: instr) and: [(instr bitAnd: 16r0FFFFFF0) = 16r12FFF10]