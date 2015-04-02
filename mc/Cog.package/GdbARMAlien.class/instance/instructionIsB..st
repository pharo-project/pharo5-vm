testing
instructionIsB: instr
"is this a B <offset> instruction?"
	"first test for non-NV condition code; some important instructions use it"
	instr >> 28 = 16rF ifTrue:[^false].
	"See ARM DDI0406A p. A8-44"
	^ (instr bitAnd: (16rF<<24)) = (16rA<<24)