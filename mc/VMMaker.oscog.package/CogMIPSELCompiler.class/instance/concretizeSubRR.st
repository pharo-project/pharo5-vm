generate machine code - concretize
concretizeSubRR
	| leftReg rightReg |
	leftReg := self concreteRegister: (operands at: 0).
	rightReg := self concreteRegister: (operands at: 1).
	self machineCodeAt: 0 put: (self subuR: rightReg R: leftReg R: rightReg).
	^machineCodeSize := 4