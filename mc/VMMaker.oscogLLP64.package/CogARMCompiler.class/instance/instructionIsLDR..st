testing
instructionIsLDR: instr
	"is this any kind of LDR instruction? c.f. memMxr:reg:base:u:b:l:imm:"
	^(self conditionIsNotNever: instr) and: [(instr >> 20 bitAnd: 16rC5) = 16r41] "ldr r1, [r2, #+/-imm] or ldr r1, [r2, r3]"