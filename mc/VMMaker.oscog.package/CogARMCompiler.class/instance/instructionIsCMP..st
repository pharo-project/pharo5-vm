testing
instructionIsCMP: instr
	"is this an CMP instruction?"
	^(instr >> 21 bitAnd: 16r7F) = CmpOpcode