generate machine code
concretizeOpRR: x64opcode
	| regLHS regRHS |
	regLHS := operands at: 0.
	regRHS := operands at: 1.
	machineCode
		at: 0 put: (self rexR: regRHS x: 0 b: regLHS);
		at: 1 put: x64opcode;
		at: 2 put: (self mod: ModReg RM: regLHS RO: regRHS).
	^machineCodeSize := 3