testing
instructionIsLDRSP: instr
"is this a LDR sp, [??] instruction? Special case to detect LDR sp, [] affecting stack pointer"
	^(self instructionIsLDR: instr)  and:[(instr >>12 bitAnd: 16rF) = 13]