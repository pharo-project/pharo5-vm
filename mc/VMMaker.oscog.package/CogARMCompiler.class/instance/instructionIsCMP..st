testing
instructionIsCMP: instr
	"is this a CMP instruction?"
	^(self conditionIsNotNever: instr) and: [(instr >> 21 bitAnd: 16r7F) = CmpOpcode]