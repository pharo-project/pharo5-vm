testing
instructionIsSTRSP: instr
"is this a STR sp, [??] instruction? Special case to detect STR sp, [] affecting stack pointer"
	^(self instructionIsSTR: instr)  and:[(instr >>12 bitAnd: 16rF) = 13]