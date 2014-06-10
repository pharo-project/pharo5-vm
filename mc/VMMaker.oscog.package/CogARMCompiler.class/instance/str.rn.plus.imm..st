ARM convenience instructions
str: destReg rn: baseReg plus: u imm: immediate12bitValue
"return a STR destReg, [baseReg, 'u' immediate12bitValue]"
	^self memMxr: AL reg: destReg  base: baseReg u: u b: 0 l: 0 imm: immediate12bitValue