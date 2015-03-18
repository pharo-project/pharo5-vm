ARM convenience instructions
ldrb: destReg rn: baseReg plus: u imm: immediate12bitValue
"	LDRB destReg, [baseReg, 'u' immediate12bitValue] u=0 -> subtract imm; =1 -> add imm "
	^self memMxr: AL reg: destReg  base: baseReg u: u b: 1 l: 1 imm: immediate12bitValue