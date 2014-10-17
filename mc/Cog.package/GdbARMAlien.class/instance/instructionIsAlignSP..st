testing
instructionIsAlignSP: instr
"is this a bics sp, sp, #7 -  instruction?"
	^instr >> 28 < 16rF "test for allowed condcode - 0xF is extension" and: [(instr bitAnd: (16rFFFFFFF)) = (16r3DDD007)]