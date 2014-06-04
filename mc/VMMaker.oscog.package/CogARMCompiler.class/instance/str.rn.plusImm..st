ARM convenience instructions
str: srcReg rn: baseReg plusImm: immediate12bitValue
"return a STR srcReg, [baseReg, +immediate12bitValue]"
	^self memMxr: AL reg: srcReg  base: baseReg u: 1 b: 0 l: 0 imm: immediate12bitValue