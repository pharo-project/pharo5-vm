ARM convenience instructions
add: destReg rn: srcReg rm: addReg
"return an ADD destReg, srcReg, addReg instruction
	ADD destReg, srcReg, addReg"

	^self type: 0 op: AddOpcode set: 0 rn: srcReg rd: destReg shifterOperand: addReg