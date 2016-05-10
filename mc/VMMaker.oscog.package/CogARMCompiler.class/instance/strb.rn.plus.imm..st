ARM convenience instructions
strb: destReg rn: baseReg plus: u imm: immediate12bitValue
"	STRB destReg, [baseReg, 'u' immediate12bitValue] u=0 -> subtract imm; =1 -> add imm  - ARM_ARM v7 DDI10406 pp. A8-388-9"
	^self memMxr: AL reg: destReg  base: baseReg u: u b: 1 l: 0 imm: immediate12bitValue