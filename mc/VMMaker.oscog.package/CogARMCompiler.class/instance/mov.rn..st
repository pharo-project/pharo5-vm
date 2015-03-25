ARM convenience instructions
mov: destReg rn: srcReg
"	MOV destReg, srcReg"

	^self type: 0 op: MoveOpcode set: 0 rn: 0 rd: destReg shifterOperand: srcReg