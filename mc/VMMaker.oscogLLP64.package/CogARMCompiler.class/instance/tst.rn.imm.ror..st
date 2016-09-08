ARM convenience instructions
tst: ignored rn: srcReg imm: immediate ror: rot
"	Remember the ROR is doubled by the cpu so use 30>>1 etc"
"also note that TST has no destReg
	TST srcReg, #immediate ROR rot - ARM_ARM v7 DDI10406 pp. A8-452-3"

	^self type: 1 op: TstOpcode set: 1 rn: srcReg rd: 0 shifterOperand: ((rot>>1) <<8 bitOr: immediate)