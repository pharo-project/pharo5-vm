testing
instructionIsBL: instr
"is this a BL <offset> instruction?"
	^(self conditionIsNotNever: instr)  and: [(instr bitAnd: (16rF<<24)) = (16rB<<24)]