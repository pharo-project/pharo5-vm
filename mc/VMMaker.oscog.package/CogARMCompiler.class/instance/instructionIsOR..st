testing
instructionIsOR: instr
	"is this an ORR instruction?"
	^(instr >> 21 bitAnd: 16rF) = 16rC