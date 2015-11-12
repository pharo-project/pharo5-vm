generate machine code - concretize
concretizeMoveRXwrR
	| srcReg indexReg baseReg |
	srcReg := self concreteRegister: (operands at: 0).
	indexReg := self concreteRegister: (operands at: 1).
	baseReg := self concreteRegister: (operands at: 2).
	self machineCodeAt: 0 put: (self sllR: AT R: indexReg C: 2). "index is number of words"
	self machineCodeAt: 4 put: (self adduR: AT R: baseReg R: AT).
	self machineCodeAt: 8 put: (self swR: srcReg base: AT offset: 0).
	^machineCodeSize := 12