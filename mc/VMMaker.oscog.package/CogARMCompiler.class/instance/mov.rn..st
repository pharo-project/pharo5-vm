ARM convenience instructions
mov: destReg rn: srcReg
"return a MOV destReg, srcReg instruction"

	^self type: 0 op: 16rD set: 0 rn: 0 rd: destReg shifterOperand: srcReg