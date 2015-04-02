testing
instructionIsAlignSP: instr
"is this a subs sp, sp, #4 -  instruction?"
	^instr >> 28 < 16rF "test for allowed condcode - 0xF is extension" and: [(instr bitAnd: (16rFFFFFFF)) = (16r2DDD004)]