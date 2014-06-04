ARM convenience instructions
ldrb: destReg rn: baseReg plus: u imm: immediate12bitValue
"return a LDRB destReg, [baseReg, 'u' immediate12bitValue]"
	^self memMxr: AL reg: destReg  base: baseReg u: u b: 1 l: 1 imm: immediate12bitValue