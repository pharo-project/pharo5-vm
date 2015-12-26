generate machine code - concretize
concretizeMoveRR
	| srcReg destReg |
	srcReg := operands at: 0.
	destReg := operands at: 1.
	self machineCodeAt: 0 put: (self adduR: destReg R: srcReg R: ZR).
	^machineCodeSize := 4