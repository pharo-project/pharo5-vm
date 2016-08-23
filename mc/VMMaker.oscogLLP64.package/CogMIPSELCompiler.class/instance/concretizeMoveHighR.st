generate machine code - concretize
concretizeMoveHighR
	| destReg |
	destReg := operands at: 0.
	self machineCodeAt: 0 put: (self mfhiR: destReg).
	^machineCodeSize := 4