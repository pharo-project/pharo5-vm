testing
instructionIsAnyLoadStore: instr
	"is this any of the LDR,STR instructions?"
	^(instr >> 24 bitAnd: 15) = 5