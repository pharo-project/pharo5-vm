generate machine code
concretizeMoveRdR
	<inline: true>
	| srcReg destReg |
	srcReg := operands at: 0.
	destReg := operands at: 1.
	machineCode
		at: 0 put: 16r66;
		at: 1 put: (self rexR: srcReg x: 0 b: destReg);
		at: 2 put: 16r0f;
		at: 3 put: 16r7e;
		at: 4 put: (self mod: ModReg RM: destReg RO: srcReg).
	^machineCodeSize := 5