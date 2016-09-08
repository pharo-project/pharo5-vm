ARM convenience instructions
add: destReg rn: srcReg rm: addReg
"return an ADD destReg, srcReg, addReg instruction
	ADD destReg, srcReg, addReg - ARM_ARM v7 DDI10406 p. A8-24"

	^self type: 0 op: AddOpcode set: 0 rn: srcReg rd: destReg shifterOperand: addReg