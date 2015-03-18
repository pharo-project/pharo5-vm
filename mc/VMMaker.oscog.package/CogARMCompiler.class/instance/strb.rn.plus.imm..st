ARM convenience instructions
strb: destReg rn: baseReg plus: u imm: immediate12bitValue
"	STRB destReg, [baseReg, 'u' immediate12bitValue] u=0 -> subtract imm; =1 -> add imm "
	^self memMxr: AL reg: destReg  base: baseReg u: u b: 1 l: 0 imm: immediate12bitValue