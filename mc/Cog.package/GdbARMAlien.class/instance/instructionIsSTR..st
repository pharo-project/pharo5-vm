testing
instructionIsSTR: instr
"is this a STR instruction?"
	| foo |
	"first test for non-NV condition code; some important instructions use it"
	instr >> 28 = 16rF ifTrue:[^false].
	"See ARM DDI0406A p. A8-382"
 	foo := (instr >> 20 bitAnd: 16rE5). 
	^foo = 16r40 "str r1, [r2, #+/-imm]" 
		or:[foo = 16r60] "str r1, [r2, #-imm]"