ARM convenience instructions
mov: destReg imm: immediate8bitValue ror: rot
	"Remember the ROR is doubled by the cpu so use 30>>1 etc.
	MOV destReg, #immediate8BitValue ROR rot - ARM_ARM v7 DDI10406 pp. A8-194-5"
	^self type: 1 op: MoveOpcode set: 0 rn: 0 rd: destReg shifterOperand: ((rot>>1) <<8 bitOr: immediate8bitValue)