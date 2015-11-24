generate machine code - concretize
concretizeAndRR
	| leftReg rightReg |
	leftReg := self concreteRegister: (operands at: 0).
	rightReg := self concreteRegister: (operands at: 1).
	self machineCodeAt: 0 put: (self andR: rightReg R: leftReg R: rightReg).
	^machineCodeSize := 4