testing
instructionIsOR: instr
	"is this an ORR instruction?"
	^(self conditionIsNotNever: instr)  and:[(instr >> 21 bitAnd: 16r7F) = (16r10 bitOr: OrOpcode)]