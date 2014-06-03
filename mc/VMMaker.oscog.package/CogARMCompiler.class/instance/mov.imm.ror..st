ARM convenience instructions
mov: destReg imm: immediate8bitValue ror: rotateRightBy
	"return the ARM instruction MOV destReg, #immediate8BitValue ROR rotateRightBy"
	^self type: 1 op: 16rD set: 0 rn: 0 rd: destReg shifterOperand: ((rotateRightBy>>1) <<8 bitOr: immediate8bitValue)