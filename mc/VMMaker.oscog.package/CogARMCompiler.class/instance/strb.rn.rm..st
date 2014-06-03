ARM convenience instructions
strb: srcReg rn: baseReg rm: offsetReg
"return a STRB srcReg, [baseReg, + offsetReg] The contents of offsetReg are assumed to be correctly signed"
	^self memMxr: AL reg: srcReg  base: baseReg p: 1 u: 1 b: 1 w: 0 l: 0 rm: offsetReg