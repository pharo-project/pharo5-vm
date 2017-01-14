generate machine code
concretizeMoveRRd
	<inline: true>
	| srcReg destReg |
	srcReg := operands at: 0.
	destReg := operands at: 1.
	machineCode
		at: 0 put: 16r66;
		at: 1 put: (self rexR: destReg x: 0 b: srcReg);
		at: 2 put: 16r0f;
		at: 3 put: 16r6e;
		at: 4 put: (self mod: ModReg RM: srcReg RO: destReg).
	^machineCodeSize := 5