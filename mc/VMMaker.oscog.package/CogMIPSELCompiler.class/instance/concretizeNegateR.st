generate machine code - concretize
concretizeNegateR
	| reg |
	reg := operands at: 0.
	self machineCodeAt: 0 put: (self subuR: reg R: ZR R: reg).
	^machineCodeSize := 4