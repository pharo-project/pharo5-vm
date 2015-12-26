generate machine code - concretize
concretizePushR
	| srcReg |
	srcReg := operands at: 0.
	self machineCodeAt: 0 put: (self addiuR: SP R: SP C: -4).
	self machineCodeAt: 4 put: (self swR: srcReg base: SP offset: 0).
	^machineCodeSize := 8