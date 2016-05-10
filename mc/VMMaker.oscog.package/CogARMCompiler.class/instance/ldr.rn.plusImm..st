ARM convenience instructions
ldr: destReg rn: baseReg plusImm: immediate12bitValue
"	LDR destReg, [baseReg, +immediate12bitValue] - ARM_ARM v7 DDI10406 pp. A8-120-1"
	^self memMxr: AL reg: destReg  base: baseReg u: 1 b: 0 l: 1 imm: immediate12bitValue