ARM convenience instructions
ldr: destReg rn: baseReg plus: u imm: immediate12bitValue
"	LDR destReg, [baseReg, immediate12bitValue] u=0 -> subtract imm; =1 -> add imm  - ARM_ARM v7 DDI10406 pp. A8-120-1"
	^self memMxr: AL reg: destReg  base: baseReg u: u b: 0 l: 1 imm: immediate12bitValue