testing
instructionIsPop: instr
"is this a pop - ldr r??, [sp], #4 -  instruction?"
	^instr >> 28 < 16rF "test for allowed condcode - 0xF is extension" and: [(instr bitAnd: (16rFFF0FFF)) = (16r49D0004)]