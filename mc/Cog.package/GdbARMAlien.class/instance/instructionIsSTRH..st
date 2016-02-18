testing
instructionIsSTRH: instr
"is this a STRH instruction?"
	| foo |
	"first test for non-NV condition code; some important instructions use it"
	instr >> 28 = 16rF ifTrue:[^false].
	"See ARM DDI0406A p. A8-154"
	(instr bitAnd: 16rF0) = 16rB0 ifFalse:[^false].
	foo := (instr >> 20 bitAnd: 16rE3).
	^foo = 16r4 "strh r1, [r2, #+/-imm]"
		or:[foo = 16r0 "strh r1, [r2, r3]"]