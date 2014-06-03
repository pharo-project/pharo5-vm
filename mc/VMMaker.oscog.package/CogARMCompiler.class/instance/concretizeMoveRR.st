generate machine code - concretize
concretizeMoveRR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| srcReg destReg |
	srcReg := self concreteRegister: (operands at: 0).
	destReg := self concreteRegister: (operands at: 1).
	"cond 000 1101 0 0000 dest 0000 0000 srcR"
	self machineCodeAt: 0 put: (self type: 0 op: 16rD set: 0 rn: 0 rd: destReg shifterOperand: srcReg).
	^machineCodeSize := 4