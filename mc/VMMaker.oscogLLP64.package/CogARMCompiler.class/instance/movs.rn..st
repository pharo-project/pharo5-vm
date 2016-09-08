ARM convenience instructions
movs: destReg rn: srcReg
"	MOVS destReg, srcReg - ARM_ARM v7 DDI10406 pp. A8-196-7"

	^self type: 0 op: MoveOpcode set: 1 rn: 0 rd: destReg shifterOperand: srcReg