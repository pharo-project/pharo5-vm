ARM convenience instructions
strb: destReg rn: baseReg plus: u imm: immediate12bitValue
"return a STRB destReg, [baseReg, 'u' immediate12bitValue]"
	^self memMxr: AL reg: destReg  base: baseReg u: u b: 1 l: 0 imm: immediate12bitValue