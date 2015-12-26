generate machine code - concretize
concretizeMoveRXbrR
	| srcReg indexReg baseReg |
	srcReg := operands at: 0.
	indexReg := operands at: 1.
	baseReg := operands at: 2.
	self machineCodeAt: 0 put: (self adduR: AT R: baseReg R: indexReg).
	self machineCodeAt: 4 put: (self sbR: srcReg base: AT offset: 0).
	^machineCodeSize := 8