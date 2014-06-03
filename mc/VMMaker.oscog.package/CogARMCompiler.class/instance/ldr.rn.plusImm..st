ARM convenience instructions
ldr: destReg rn: baseReg plusImm: immediate12bitValue
"return a LDR destReg, [baseReg, +immediate12bitValue]"
	^self memMxr: AL reg: destReg  base: baseReg u: 1 b: 0 l: 1 imm: immediate12bitValue