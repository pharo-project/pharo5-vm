ARM convenience instructions
ldr: destReg rn: baseReg rm: offsetReg
"	LDR destReg, [baseReg, + offsetReg]  - ARM_ARM v7 DDI10406 pp. A8-124-5
	The contents of offsetReg are assumed to be correctly signed"
	^self memMxr: AL reg: destReg  base: baseReg p: 1 u: 1 b: 0 w: 0 l: 1 rm: offsetReg