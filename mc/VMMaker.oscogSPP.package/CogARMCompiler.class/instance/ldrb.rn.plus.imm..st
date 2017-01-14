ARM convenience instructions
ldrb: destReg rn: baseReg plus: u imm: immediate12bitValue
"	LDRB destReg, [baseReg, 'u' immediate12bitValue] u=0 ->  - ARM_ARM v7 DDI10406 pp. A8-128-9
	Note that this is a very low level interface that does not check the sign of the immediate, nor validity. See for example #concretizeMoveMbrR"
	^self memMxr: AL reg: destReg  base: baseReg u: u b: 1 l: 1 imm: immediate12bitValue