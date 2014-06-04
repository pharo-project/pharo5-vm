testing
instructionIsB: instr
"is this a B <offset> instruction?"
	^instr >> 28 < 16rF "test for allowed condcode - 0xF is extension" and: [(instr bitAnd: (16rF<<24)) = (16rA<<24)]