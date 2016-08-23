ARM convenience instructions
str: destReg rn: baseReg plus: u imm: immediate12bitValue
"	STR destReg, [baseReg, 'u' immediate12bitValue] u=0 -> subtract imm; =1 -> add imm - ARM_ARM v7 DDI10406 pp. A8-382-3 "
	^self memMxr: AL reg: destReg  base: baseReg u: u b: 0 l: 0 imm: immediate12bitValue