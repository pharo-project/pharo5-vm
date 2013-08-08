generate machine code - concretize
concretizeArithmeticShiftRightRR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| destReg distReg |
	distReg := self concreteRegister: (operands at: 0).
	destReg := self concreteRegister: (operands at: 1).
	"cond 000 1101 0 0000 dest dist 0101 srcR"
	self machineCodeAt: 0 put: (self t: 0 o: 16rD s: 0 rn: 0 rd: destReg 
									shifterOperand: (distReg << 8 bitOr: (80 bitOr: destReg))).
	^machineCodeSize := 4