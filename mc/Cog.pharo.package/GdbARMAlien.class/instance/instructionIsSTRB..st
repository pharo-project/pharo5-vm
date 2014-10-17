testing
instructionIsSTRB: instr
"is this a STRB instruction?"
	| foo |
	^instr >> 28 < 16rF "test for allowed condcode - 0xF is extension" and: [foo := (instr >> 20 bitAnd: 16rFF). foo = 16r54 "strb r1, [r2, #imm]" or:[foo = 16r5c "strb r1, [r2, #-imm]" or:[foo = 16r7c "strb r1, [r2, r3]"]]]