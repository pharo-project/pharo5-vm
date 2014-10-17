testing
instructionIsLDR: instr
"is this a LDR instruction?"
	| foo |
	^instr >> 28 < 16rF "test for allowed condcode - 0xF is extension" 
		and: [foo := (instr >> 20 bitAnd: 16rFF).
			foo = 16r51 "ldr r1, [r2, #imm]"
				or:[foo = 16r59 "ldr r1, [r2, #-imm]"
				or:[foo = 16r79 "ldr r1, [r2, r3]"]]]