ARM convenience instructions
bics: destReg rn: srcReg imm: immediate ror: rot
"Remember the ROR is doubled by the cpu so use 30>>1 etc
	BICS destReg, srcReg, #immediate ROR #rot - ARM_ARM v7 DDI10406 pp. A8-50-1"

	^self type: 1 op: BicOpcode set: 1 rn: srcReg rd: destReg shifterOperand: ((rot>>1) <<8 bitOr: immediate)