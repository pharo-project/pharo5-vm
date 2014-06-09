ARM convenience instructions
ands: destReg rn: srcReg imm: immediate ror: rot
"return an ANDS destReg, srcReg, immediat ROR rot instruction. Remember the ROR is doubled by the cpu so use 30>>1 etc"

	^self type: 1 op: 0 set: 1 rn: srcReg rd: destReg shifterOperand: ((rot>>1) <<8 bitOr: immediate)