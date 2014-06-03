generate machine code - concretize
concretizeLogicalShiftRightRR
	"Will get inlined into concretizeAt: switch."
	"this is an unfortunate waste of an instruction in most cases since the shift can usually be done in a subsequent arithmetic instruction. 
	Handle for now with a MOV reg, reg, LSR distReg"
	<inline: true>
	| destReg distReg |
	distReg := self concreteRegister: (operands at: 0).
	destReg := self concreteRegister: (operands at: 1).
	"cond 000 1101 0 0000 dest dist 0011 srcR"
	self machineCodeAt: 0 put: (self type: 0 op: 16rD set: 0 rn: 0 rd: destReg 
									shifterOperand: (distReg << 8 bitOr: (48 bitOr: destReg))).
	^machineCodeSize := 4