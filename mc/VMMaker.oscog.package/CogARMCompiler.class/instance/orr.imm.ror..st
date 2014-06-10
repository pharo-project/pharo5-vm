ARM convenience instructions
orr: destReg imm: immediate8bitValue ror: rotateRightBy
	"return the ARM instruction ORR destReg, #immediate8BitValue ROR rotateRightBy"
	^self type: 1 op: 16rC set: 0 rn: destReg rd: destReg shifterOperand: ((rotateRightBy>>1) <<8 bitOr: immediate8bitValue)