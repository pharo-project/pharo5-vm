generate machine code - concretize
concretizePopR
	| destReg |
	destReg := operands at: 0.
	self machineCodeAt: 0 put: (self lwR: destReg base: SP offset: 0).
	self machineCodeAt: 4 put: (self addiuR: SP R: SP C: 4).
	^machineCodeSize := 8