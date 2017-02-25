generate machine code - concretize
concretizeMoveXwrRR
	| indexReg baseReg destReg |
	indexReg := operands at: 0.
	baseReg := operands at: 1.
	destReg := operands at: 2.
	self machineCodeAt: 0 put: (self sllR: AT R: indexReg C: 2). "index is in words"
	self machineCodeAt: 4 put: (self adduR: AT R: baseReg R: AT).
	self machineCodeAt: 8 put: (self lwR: destReg base: AT offset: 0).
	^machineCodeSize := 12