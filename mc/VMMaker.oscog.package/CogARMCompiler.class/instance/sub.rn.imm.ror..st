ARM convenience instructions
sub: destReg rn: srcReg imm: immediate ror: rot
"	Remember the ROR is doubled by the cpu so use 30>>1 etc
	SUB destReg, srcReg, #immediate ROR rot"

	^self type: 1 op: 2 set: 0 rn: srcReg rd: destReg shifterOperand: ((rot>>1) <<8 bitOr: immediate)