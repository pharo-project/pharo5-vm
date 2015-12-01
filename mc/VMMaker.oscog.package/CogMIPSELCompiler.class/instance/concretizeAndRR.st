generate machine code - concretize
concretizeAndRR
	| destReg leftReg rightReg |
	rightReg := self concreteRegister: (operands at: 0).
	destReg := leftReg := self concreteRegister: (operands at: 1).
	self machineCodeAt: 0 put: (self andR: destReg R: leftReg R: rightReg).
	^machineCodeSize := 4