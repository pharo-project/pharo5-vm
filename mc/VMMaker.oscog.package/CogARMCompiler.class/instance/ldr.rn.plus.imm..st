ARM convenience instructions
ldr: destReg rn: baseReg plus: u imm: immediate12bitValue
"return a LDR destReg, [baseReg, 'u' immediate12bitValue]"
	^self memMxr: AL reg: destReg  base: baseReg u: u b: 0 l: 1 imm: immediate12bitValue