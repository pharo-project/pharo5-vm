testing
instructionIsBX: instr
"is this a BX <targetReg> instruction?"
	"first test for non-NV condition code; some important instructions use it"
	instr >> 28 = 16rF ifTrue:[^false].
	"See ARM DDI0406A p. A8-62"
 	^(instr bitAnd: 16r0FFFFFF0) = 16r12FFF10