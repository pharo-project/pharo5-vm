ARM convenience instructions
popR: dstReg
"	pop word off TOS
	LDR srcReg, [sp] #4 - ARM_ARM v7 DDI10406 pp. A8-120-1"
	^self memMxr: AL reg: dstReg base: SP p: 0 u: 1 b: 0 w: 0 l: 1 imm: 4