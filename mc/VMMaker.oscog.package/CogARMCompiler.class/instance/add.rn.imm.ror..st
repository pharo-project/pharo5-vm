ARM convenience instructions
add: destReg rn: srcReg imm: immediate ror: rot
"return an ADD destReg, srcReg, immediat ROR rot instruction. Remember the ROR is doubled by the cpu so use 30>>1 etc"

	^self type: 1 op: 4 set: 0 rn: srcReg rd: destReg shifterOperand: ((rot>>1) <<8 bitOr: immediate)