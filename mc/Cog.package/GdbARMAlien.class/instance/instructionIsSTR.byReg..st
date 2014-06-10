testing
instructionIsSTR: instr byReg: rn
"is this a STR r1, [r2, rn] instruction? Special case to detect MoveRAw case"
	| foo |
	^instr >> 28 < 16rF "test for allowed condcode - 0xF is extension" and: [foo := (instr >> 20 bitAnd: 16rFF). foo = 16r58  and:[(instr >>16 bitAnd: 16rF) = rn]]