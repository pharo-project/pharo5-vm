ARM convenience instructions
add: destReg rn: srcReg imm: immediate ror: rot
"return an ADD destReg, srcReg, immediat ROR rot instruction"

	^self type: 1 op: 4 set: 0 rn: srcReg rd: destReg shifterOperand: (rot <<8 bitOr: immediate)