testing
instructionIsBL: instr
"is this a BL <offset> instruction?"
	^instr >> 28 < 16rF "test for allowed condcode - 0xF is extension" and: [(instr bitAnd: (16rF<<24)) = (16rB<<24)]