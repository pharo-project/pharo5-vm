ARM convenience instructions
str: srcReg rn: baseReg plusImm: immediate12bitValue
"	STR srcReg, [baseReg, +immediate12bitValue] - ARM_ARM v7 DDI10406 pp. A8-382-3"
	^self memMxr: AL reg: srcReg  base: baseReg u: 1 b: 0 l: 0 imm: immediate12bitValue