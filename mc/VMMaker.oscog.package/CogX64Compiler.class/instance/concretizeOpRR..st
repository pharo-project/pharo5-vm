generate machine code
concretizeOpRR: opcode
	| regLHS regRHS |
	regLHS := self concreteRegister: (operands at: 0).
	regRHS := self concreteRegister: (operands at: 1).
	machineCode
		at: 0 put: (self rexR: regRHS x: 0 b: regLHS);
		at: 1 put: opcode;
		at: 2 put: (self mod: ModReg RM: regLHS RO: regRHS).
	^machineCodeSize := 3