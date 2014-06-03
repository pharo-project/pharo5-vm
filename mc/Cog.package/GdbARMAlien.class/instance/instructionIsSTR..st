testing
instructionIsSTR: instr
"is this a STR instruction?"
	| foo |
	^instr >> 28 < 16rF "test for allowed condcode - 0xF is extension" and: [foo := (instr >> 20 bitAnd: 16rFF). foo = 16r58 "str r1, [r2, #imm]" or:[foo = 16r50 "str r1, [r2, #-imm]" or:[foo = 16r78 "str r1, [r2, r3]"]]]