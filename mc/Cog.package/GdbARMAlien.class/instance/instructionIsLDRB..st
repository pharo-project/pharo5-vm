testing
instructionIsLDRB: instr
"is this a LDRB instruction?"
	| foo |
	^instr >> 28 < 16rF "test for allowed condcode - 0xF is extension" 
		and: [foo := (instr >> 20 bitAnd: 16rFF).
			foo = 16r55 "ldrb r1, [r2, #imm]"
				or:[foo = 16r5D "ldrb r1, [r2, #-imm]"
				or:[foo = 16r7D "ldrb r1, [r2, r3]"]]]