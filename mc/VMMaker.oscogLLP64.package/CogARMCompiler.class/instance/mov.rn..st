ARM convenience instructions
mov: destReg rn: srcReg
"	MOV destReg, srcReg - ARM_ARM v7 DDI10406 pp. A8-196-7"

	^self type: 0 op: MoveOpcode set: 0 rn: 0 rd: destReg shifterOperand: srcReg