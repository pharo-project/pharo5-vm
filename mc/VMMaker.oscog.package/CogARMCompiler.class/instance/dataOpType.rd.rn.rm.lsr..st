ARM convenience instructions
dataOpType: armOpcode rd: destReg rn: srcReg rm: addReg lsr: shft
"return an {opcode} destReg, srcReg, addReg lsl #shft"
"important detail - a 0 shft requires setting the shift-type code to 0 to avoid potential instruction confusion"
	shft = 0
		ifTrue:[^self type: 0 op: armOpcode set: 1 rn: srcReg rd: destReg shifterOperand: addReg]
		ifFalse:[^self type: 0 op: armOpcode set: 1 rn: srcReg rd: destReg shifterOperand: ((shft <<7 bitOr: 32) bitOr:  addReg)]