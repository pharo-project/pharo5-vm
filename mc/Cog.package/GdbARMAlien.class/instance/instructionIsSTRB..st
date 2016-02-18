testing
instructionIsSTRB: instr
"is this a STRB instruction?"
	| foo |
	"first test for non-NV condition code; some important instructions use it"
	instr >> 28 = 16rF ifTrue:[^false].
	"See ARM DDI0406A p. A8-388"
 	foo := (instr >> 20 bitAnd: 16rE5). 
	^foo = 16r44 "strb r1, [r2, #+/-imm]" 
		or:[foo = 16r64] "strb r1, [r2, #-imm]"