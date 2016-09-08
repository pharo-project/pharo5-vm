ARM convenience instructions
ldrb: destReg rn: baseReg rm: offsetReg
"	LDRB destReg, [baseReg, + offsetReg]  - ARM_ARM v7 DDI10406 pp. A8-132-3
	The contents of offsetReg are assumed to be correctly signed"
	^self memMxr: AL reg: destReg  base: baseReg p: 1 u: 1 b: 1 w: 0 l: 1 rm: offsetReg