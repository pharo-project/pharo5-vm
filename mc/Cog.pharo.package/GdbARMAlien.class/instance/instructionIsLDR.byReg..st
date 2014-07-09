testing
instructionIsLDR: instr byReg: rn
"is this a LDR r1, [r2, rn] instruction? Special case to detect MoveAwR case"
	| foo |
	^instr >> 28 < 16rF "test for allowed condcode - 0xF is extension" and: [foo := (instr >> 20 bitAnd: 16rFF). foo = 16r59  and:[(instr >>16 bitAnd: 16rF) = rn]]