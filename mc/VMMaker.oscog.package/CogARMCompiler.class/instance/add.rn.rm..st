ARM convenience instructions
add: destReg rn: srcReg rm: addReg
"return an ADD destReg, srcReg, addReg instruction"

	^self type: 0 op: 4 set: 0 rn: srcReg rd: destReg shifterOperand: addReg