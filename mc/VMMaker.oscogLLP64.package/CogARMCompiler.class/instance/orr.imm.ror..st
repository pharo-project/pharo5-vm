ARM convenience instructions
orr: destReg imm: immediate8bitValue ror: rot
	"Remember the ROR is doubled by the cpu so use 30>>1 etc.
	ORR destReg, #immediate8BitValue ROR rot - ARM_ARM v7 DDI10406 pp. A8-228-9"
	^self type: 1 op: OrOpcode set: 0 rn: destReg rd: destReg shifterOperand: ((rot>>1) <<8 bitOr: immediate8bitValue)