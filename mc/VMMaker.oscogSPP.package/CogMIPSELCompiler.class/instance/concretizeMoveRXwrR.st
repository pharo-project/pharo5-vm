generate machine code - concretize
concretizeMoveRXwrR
	| srcReg indexReg baseReg |
	srcReg := operands at: 0.
	indexReg := operands at: 1.
	baseReg := operands at: 2.
	self machineCodeAt: 0 put: (self sllR: AT R: indexReg C: 2). "index is number of words"
	self machineCodeAt: 4 put: (self adduR: AT R: baseReg R: AT).
	self machineCodeAt: 8 put: (self swR: srcReg base: AT offset: 0).
	^machineCodeSize := 12