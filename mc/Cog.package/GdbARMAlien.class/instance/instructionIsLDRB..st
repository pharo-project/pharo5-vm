testing
instructionIsLDRB: instr
"is this a LDRB instruction?"
	| foo |
	"first test for non-NV condition code; some important instructions use it"
	instr >> 28 = 16rF ifTrue:[^false].
	"See ARM DDI0406A p. A8-128"
	foo := (instr >> 20 bitAnd: 16rE5).
	^foo = 16r45 "ldrb r1, [r2, #+/-imm]"
		or:[foo = 16r65 "ldrb r1, [r2, r3]"]