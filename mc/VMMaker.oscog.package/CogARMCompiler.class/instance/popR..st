ARM convenience instructions
popR: dstReg
"return a pop - LDR srcReg, [sp] #4"
	^self memMxr: AL reg: dstReg base: SP p: 0 u: 1 b: 0 w: 0 l: 1 imm: 4