testing
instructionIsAddSP: instr
"is this aadd sp, sp, #? -  instruction?"
	^instr >> 28 < 16rF "test for allowed condcode - 0xF is extension" and: [(instr bitAnd: (16rFFFFF00)) = (16r28DD000)]