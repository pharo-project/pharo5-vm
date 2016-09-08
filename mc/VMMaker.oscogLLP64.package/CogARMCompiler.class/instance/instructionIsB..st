testing
instructionIsB: instr
"is this a B <offset> instruction?"
	^(self conditionIsNotNever: instr) and: [(instr bitAnd: (16rF<<24)) = (16rA<<24)]