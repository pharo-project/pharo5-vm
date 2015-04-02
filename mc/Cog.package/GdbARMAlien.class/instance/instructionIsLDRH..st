testing
instructionIsLDRH: instr
"is this a LDRH instruction?"
	| foo |
	"first test for non-NV condition code; some important instructions use it"
	instr >> 28 = 16rF ifTrue:[^false].
	"See ARM DDI0406A p. A8-154"
	(instr bitAnd: 16rF0) = 16rB0 ifFalse:[^false].
	foo := (instr >> 20 bitAnd: 16rE3).
	^foo = 16r3 "ldrh r1, [r2, #+/-imm]"
		or:[foo = 16r1 "ldrh r1, [r2, r3]"]