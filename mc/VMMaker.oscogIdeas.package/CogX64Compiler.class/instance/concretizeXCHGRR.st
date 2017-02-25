generate machine code
concretizeXCHGRR
	| r1 r2 |
	r1 := operands at: 0.
	r2 := operands at: 1.
	r2 = RAX ifTrue:
		[r2 := r1. r1 := RAX].
	r1 = RAX ifTrue:
		[machineCode
			at: 0 put: (self rexR: 0 x: 0 b: r2);
			at: 1 put: 16r90 + (r2 \\ 8).
		 ^machineCodeSize := 2].
	machineCode
		at: 0 put: (self rexR: r1 x: 0 b: r2);
		at: 1 put: 16r87;
		at: 2 put: (self mod: ModReg RM: r2 RO: r1).
	^machineCodeSize := 3