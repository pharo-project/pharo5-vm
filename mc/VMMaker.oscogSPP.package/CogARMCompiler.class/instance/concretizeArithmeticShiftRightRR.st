generate machine code - concretize
concretizeArithmeticShiftRightRR
	"Will get inlined into concretizeAt: switch."
	"this is an unfortunate waste of an instruction in most cases since the shift can usually be done in a subsequent arithmetic instruction. 
	Handle for now with a MOVS reg, reg, ASR distReg"
	<inline: true>
	| destReg distReg |
	distReg := operands at: 0.
	destReg := operands at: 1.
	"cond 000 1101 0 0000 destR distR 0101 srcR"
	self machineCodeAt: 0 put: (self type: 0 op: MoveOpcode set: 1 rn: 0 rd: destReg 
									shifterOperand: (distReg << 8 bitOr: (80 bitOr: destReg))).
	^machineCodeSize := 4