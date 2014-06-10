ARM convenience instructions
subs: destReg rn: srcReg imm: immediate ror: rot
"return a SUBDS destReg, srcReg, immediat ROR rot instruction. Remember the ROR is doubled by the cpu so use 30>>1 etc"

	^self type: 1 op: 2 set: 1 rn: srcReg rd: destReg shifterOperand: ((rot>>1) <<8 bitOr: immediate)