ARM convenience instructions
str: srcReg rn: baseReg rm: offsetReg
"return a STR srcReg, [baseReg, + offsetReg] The contents of offsetReg are assumed to be correctly signed"
	^self memMxr: AL reg: srcReg  base: baseReg p: 1 u: 1 b: 0 w: 0 l: 0 rm: offsetReg