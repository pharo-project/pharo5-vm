generate machine code - concretize
concretizeMoveXbrRR
	| indexReg baseReg destReg |
	indexReg := operands at: 0. "index is number of *bytes*"
	baseReg := operands at: 1.
	destReg := operands at: 2.
	self machineCodeAt: 0 put: (self adduR: AT R: baseReg R: indexReg).
	self machineCodeAt: 4 put: (self lbuR: destReg base: AT offset: 0).
	^machineCodeSize := 8