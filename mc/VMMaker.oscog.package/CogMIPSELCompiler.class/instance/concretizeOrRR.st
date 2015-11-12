generate machine code - concretize
concretizeOrRR
	| leftReg rightReg |
	leftReg := self concreteRegister: (operands at: 0).
	rightReg := self concreteRegister: (operands at: 1).
	self machineCodeAt: 0 put: (self orR: rightReg R: leftReg R: rightReg).
	^machineCodeSize := 4