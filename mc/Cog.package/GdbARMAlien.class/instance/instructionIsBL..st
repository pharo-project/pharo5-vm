testing
instructionIsBL: instr
"is this a BL <offset> instruction?"
	"first test for non-NV condition code; some important instructions use it"
	instr >> 28 = 16rF ifTrue:[^false].
	"see ARM DDI0406A p. A8-58"
	^(instr bitAnd: (16rF<<24)) = (16rB<<24)