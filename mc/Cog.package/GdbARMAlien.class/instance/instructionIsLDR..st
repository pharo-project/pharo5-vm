testing
instructionIsLDR: instr
"is this a LDR instruction?"
	| foo |
	"first test for non-NV condition code; some important instructions use it"
	instr >> 28 = 16rF ifTrue:[^false].
	"See ARM DDI0406A p. A8-120"
	foo := (instr >> 20 bitAnd: 16rE5).
	^foo = 16r41 "ldr r1, [r2, #+/-imm]"
		or:[foo = 16r61 "ldr r1, [r2, r3]"]