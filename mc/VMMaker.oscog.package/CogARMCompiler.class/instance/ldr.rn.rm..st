ARM convenience instructions
ldr: destReg rn: baseReg rm: offsetReg
"return a LDR destReg, [baseReg, + offsetReg] The contents of offsetReg are assumed to be correctly signed"
	^self memMxr: AL reg: destReg  base: baseReg p: 1 u: 1 b: 0 w: 0 l: 1 rm: offsetReg