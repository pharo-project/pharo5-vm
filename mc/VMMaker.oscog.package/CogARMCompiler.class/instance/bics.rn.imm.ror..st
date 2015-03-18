ARM convenience instructions
bics: destReg rn: srcReg imm: immediate ror: rot
"Remember the ROR is doubled by the cpu so use 30>>1 etc
	BICS destReg, srcReg, #immediate ROR #rot"

	^self type: 1 op: 14 set: 1 rn: srcReg rd: destReg shifterOperand: ((rot>>1) <<8 bitOr: immediate)